import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'package:fixnum/fixnum.dart' as fixnum;

import 'api_methods.dart';
import 'pages/new_or_import_profile.dart';
import 'models.dart' as models;
import 'protocol.pb.dart' as protocol;
import 'synchronizer.dart' as synchronizer;
import 'queries.dart' as queries;
import 'logger.dart';

class ProcessSecret {
  cryptography.SimpleKeyPair system;
  List<int> process;

  ProcessSecret(this.system, this.process);
}

Future<ProcessSecret> createNewIdentity(sqflite.Database db) async {
  final algorithm = cryptography.Ed25519();
  final keyPair = await algorithm.newKeyPair();

  return await db.transaction((transaction) async {
    return await importIdentity(transaction, keyPair);
  });
}

Future<ProcessSecret> importIdentity(
  sqflite.Transaction transaction,
  cryptography.SimpleKeyPair keyPair,
) async {
  final public = await keyPair.extractPublicKey();

  final privateBytes = await keyPair.extractPrivateKeyBytes();
  final publicBytes = public.bytes;

  final process = List<int>.generate(16, (i) => Random.secure().nextInt(256));

  await queries.insertProcessSecret(
    transaction,
    Uint8List.fromList(publicBytes),
    Uint8List.fromList(privateBytes),
    1,
    Uint8List.fromList(process),
  );

  final publicProto = protocol.PublicKey(
    keyType: fixnum.Int64(1),
    key: public.bytes,
  );

  logger.i("imported: ${base64Url.encode(publicProto.writeToBuffer())}");

  return ProcessSecret(keyPair, process);
}

Future<List<ProcessSecret>> loadIdentities(sqflite.Database db) async {
  final List<Map> rows = await db.rawQuery('''
        SELECT * FROM process_secrets;
    ''');

  final result = List<ProcessSecret>.empty(growable: true);

  for (var row in rows) {
    final public = cryptography.SimplePublicKey(
      row['system_key_pub'] as List<int>,
      type: cryptography.KeyPairType.ed25519,
    );

    final keyPair = cryptography.SimpleKeyPairData(
      row['system_key'] as List<int>,
      publicKey: public,
      type: cryptography.KeyPairType.ed25519,
    );

    result.add(
      ProcessSecret(keyPair, row['process'] as List<int>),
    );
  }

  return result;
}

Future<String> makeExportBundle(
  sqflite.Database db,
  ProcessSecret processSecret,
) async {
  final privateKey = await processSecret.system.extractPrivateKeyBytes();
  final publicKey = (await processSecret.system.extractPublicKey()).bytes;

  final exportBundle = protocol.ExportBundle(
    keyPair: protocol.KeyPair(
      keyType: fixnum.Int64(1),
      privateKey: privateKey,
      publicKey: publicKey,
    ),
    events: protocol.Events(),
  );

  return "polycentric://${base64Url.encode(exportBundle.writeToBuffer())}";
}

Future<void> importExportBundle(
  sqflite.Database db,
  protocol.ExportBundle exportBundle,
) async {
  final public = cryptography.SimplePublicKey(
    exportBundle.keyPair.publicKey,
    type: cryptography.KeyPairType.ed25519,
  );

  final keyPair = cryptography.SimpleKeyPairData(
    exportBundle.keyPair.privateKey,
    publicKey: public,
    type: cryptography.KeyPairType.ed25519,
  );

  await db.transaction((transaction) async {
    await importIdentity(transaction, keyPair);

    for (final event in exportBundle.events.events) {
      await ingest(transaction, event);
    }
  });
}

Future<void> ingest(
  sqflite.Transaction transaction,
  protocol.SignedEvent signedEvent,
) async {
  final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

  final public = cryptography.SimplePublicKey(
    event.system.key,
    type: cryptography.KeyPairType.ed25519,
  );

  final signature = cryptography.Signature(
    signedEvent.signature,
    publicKey: public,
  );

  final validSignature = await cryptography.Ed25519().verify(
    signedEvent.event,
    signature: signature,
  );

  if (!validSignature) {
    throw 'invalid signature';
  }

  if (await queries.doesEventExist(transaction, event)) {
    logger.d("event already persisted");
    return;
  }

  if (await queries.isEventDeleted(transaction, event)) {
    logger.d("event already deleted");
    return;
  }

  final eventId = await queries.insertEvent(transaction, signedEvent, event);

  if (event.contentType == models.ContentType.contentTypeDelete) {
    final protocol.Delete deleteBody =
        protocol.Delete.fromBuffer(event.content);

    await queries.deleteEventDB(transaction, eventId, event.system, deleteBody);
  }

  if (event.hasLwwElement()) {
    await queries.insertLWWElement(transaction, eventId, event.lwwElement);
  }
}

Future<protocol.Pointer> signedEventToPointer(
    protocol.SignedEvent signedEvent) async {
  final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

  final hash = await cryptography.Sha256().hash(signedEvent.event);

  return protocol.Pointer(
    system: event.system,
    process: event.process,
    logicalClock: event.logicalClock,
    eventDigest: protocol.Digest(
      digestType: fixnum.Int64(1),
      digest: hash.bytes,
    ),
  );
}

Future<List<ClaimInfo>> loadClaims(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final signedEvents = await queries.loadEventsForSystemByContentType(
    transaction,
    system,
    fixnum.Int64(12),
  );

  final List<ClaimInfo> result = [];

  for (final signedEvent in signedEvents) {
    protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    protocol.Claim claim = protocol.Claim.fromBuffer(event.content);

    protocol.ClaimIdentifier claimIdentifier =
        protocol.ClaimIdentifier.fromBuffer(claim.claim);

    final pointer = await signedEventToPointer(signedEvent);

    result.add(ClaimInfo(claim.claimType, claimIdentifier.identifier, pointer));
  }

  return result;
}

Future<void> sendAllEventsToServer(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final rows = await transaction.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?;
    ''', [Uint8List.fromList(system)]);

  final protocol.Events payload = protocol.Events();

  for (final row in rows) {
    final rawEvent = row['raw_event'];

    final protocol.SignedEvent signedEvent =
        protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

    payload.events.add(signedEvent);
  }

  await postEvents(payload);
}

Future<String> loadLatestUsername(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final signedEvent = await queries.loadLatestCRDTByContentType(
    transaction,
    system,
    models.ContentType.contentTypeUsername,
  );

  if (signedEvent == null) {
    return 'unknown';
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    return utf8.decode(event.lwwElement.value);
  }
}

Future<String> loadLatestDescription(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final signedEvent = await queries.loadLatestCRDTByContentType(
    transaction,
    system,
    models.ContentType.contentTypeDescription,
  );

  if (signedEvent == null) {
    return '';
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    return utf8.decode(event.lwwElement.value);
  }
}

Future<Image?> loadImage(
  sqflite.Transaction transaction,
  protocol.Pointer pointer,
) async {
  final metaSignedEvent = await queries.loadEvent(
    transaction,
    pointer.system.key,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (metaSignedEvent == null) {
    return null;
  }

  final metaEvent = protocol.Event.fromBuffer(metaSignedEvent.event);

  if (metaEvent.contentType != models.ContentType.contentTypeBlobMeta) {
    logger.d(
        "expected blob meta event but got: ${metaEvent.contentType.toString()}");

    return null;
  }

  // final blobMeta = Protocol.BlobMeta.fromBuffer(metaEvent.content);

  final contentSignedEvent = await queries.loadEvent(
    transaction,
    metaEvent.system.key,
    metaEvent.process.process,
    metaEvent.logicalClock + 1,
  );

  if (contentSignedEvent == null) {
    return null;
  }

  final contentEvent = protocol.Event.fromBuffer(contentSignedEvent.event);

  if (contentEvent.contentType != models.ContentType.contentTypeBlobSection) {
    logger.d("expected blob section event but got: "
        "${contentEvent.contentType.toString()}");

    return null;
  }

  final blobSection = protocol.BlobSection.fromBuffer(contentEvent.content);

  return Image.memory(Uint8List.fromList(blobSection.content));
}

Future<Image?> loadLatestAvatar(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final signedEvent = await queries.loadLatestCRDTByContentType(
    transaction,
    system,
    models.ContentType.contentTypeAvatar,
  );

  if (signedEvent == null) {
    return null;
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    if (event.contentType != models.ContentType.contentTypeAvatar) {
      logger.d("expected blob section event but got: "
          "${event.contentType.toString()}");

      return null;
    }

    final protocol.Pointer pointer = protocol.Pointer.fromBuffer(
      event.lwwElement.value,
    );

    return loadImage(transaction, pointer);
  }
}

Future<protocol.Pointer> saveEvent(sqflite.Transaction transaction,
    ProcessSecret processInfo, protocol.Event event) async {
  final public = await processInfo.system.extractPublicKey();
  final protocol.PublicKey system = protocol.PublicKey();
  system.keyType = fixnum.Int64(1);
  system.key = public.bytes;

  final protocol.Process process = protocol.Process(
    process: processInfo.process,
  );

  final clock = await queries.loadLatestClock(
    transaction,
    public.bytes,
    processInfo.process,
  );

  event.system = system;
  event.process = process;
  event.logicalClock = fixnum.Int64(clock);
  event.vectorClock = protocol.VectorClock();
  event.indices = protocol.Indices();

  final encoded = event.writeToBuffer();
  final signature = (await cryptography.Ed25519().sign(
    encoded,
    keyPair: processInfo.system,
  ))
      .bytes;

  final protocol.SignedEvent signedEvent = protocol.SignedEvent(
    event: encoded,
    signature: signature,
  );

  await ingest(transaction, signedEvent);

  sendAllEventsToServer(transaction, public.bytes);

  return await signedEventToPointer(signedEvent);
}

Future<void> deleteEvent(
  sqflite.Transaction transaction,
  ProcessSecret processInfo,
  protocol.Pointer pointer,
) async {
  final signedEvent = await queries.loadEvent(
    transaction,
    pointer.system.key,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (signedEvent == null) {
    logger.d("cannot delete event that does not exist");
    return;
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    final protocol.Event deleteEvent = protocol.Event(
      contentType: models.ContentType.contentTypeDelete,
      content: protocol.Delete(
        process: pointer.process,
        logicalClock: pointer.logicalClock,
        indices: event.indices,
      ).writeToBuffer(),
    );

    await saveEvent(transaction, processInfo, deleteEvent);
  }
}

Future<protocol.Pointer> publishBlob(sqflite.Transaction transaction,
    ProcessSecret processInfo, String mime, List<int> bytes) async {
  final protocol.Event blobMetaEvent = protocol.Event(
    contentType: models.ContentType.contentTypeBlobMeta,
    content: protocol.BlobMeta(
      sectionCount: fixnum.Int64(1),
      mime: mime,
    ).writeToBuffer(),
  );

  final blobMetaPointer = await saveEvent(
    transaction,
    processInfo,
    blobMetaEvent,
  );

  final blobSectionEvent = protocol.Event(
    contentType: models.ContentType.contentTypeBlobSection,
    content: protocol.BlobSection(
      metaPointer: blobMetaPointer.logicalClock,
      content: bytes,
    ).writeToBuffer(),
  );

  await saveEvent(transaction, processInfo, blobSectionEvent);

  return blobMetaPointer;
}

Future<void> setCRDT(sqflite.Transaction transaction, ProcessSecret processInfo,
    fixnum.Int64 contentType, Uint8List bytes) async {
  final protocol.Event event = protocol.Event(
    contentType: contentType,
    lwwElement: protocol.LWWElement(
      unixMilliseconds: fixnum.Int64(DateTime.now().millisecondsSinceEpoch),
      value: bytes,
    ),
  );

  await saveEvent(transaction, processInfo, event);
}

Future<void> setAvatar(sqflite.Transaction transaction,
    ProcessSecret processInfo, protocol.Pointer pointer) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeAvatar,
    pointer.writeToBuffer(),
  );
}

Future<void> setUsername(sqflite.Transaction transaction,
    ProcessSecret processInfo, String username) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeUsername,
    Uint8List.fromList(utf8.encode(username)),
  );
}

Future<void> setDescription(sqflite.Transaction transaction,
    ProcessSecret processInfo, String description) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeDescription,
    Uint8List.fromList(utf8.encode(description)),
  );
}

Future<void> makeClaim(sqflite.Transaction transaction,
    ProcessSecret processInfo, String claimText) async {
  final protocol.Event event = protocol.Event(
    contentType: models.ContentType.contentTypeClaim,
    content: protocol.Claim(
      claimType: "Generic",
      claim: protocol.ClaimIdentifier(
        identifier: claimText,
      ).writeToBuffer(),
    ).writeToBuffer(),
  );

  await saveEvent(transaction, processInfo, event);
}

Future<ClaimInfo> makePlatformClaim(sqflite.Transaction transaction,
    ProcessSecret processInfo, String claimType, String account) async {
  final protocol.Event event = protocol.Event(
    contentType: models.ContentType.contentTypeClaim,
    content: protocol.Claim(
      claimType: claimType,
      claim: protocol.ClaimIdentifier(
        identifier: account,
      ).writeToBuffer(),
    ).writeToBuffer(),
  );

  final pointer = await saveEvent(transaction, processInfo, event);

  return ClaimInfo(claimType, account, pointer);
}

Future<ClaimInfo> makeOccupationClaim(
    sqflite.Transaction transaction,
    ProcessSecret processInfo,
    String organization,
    String role,
    String location) async {
  final protocol.Event event = protocol.Event(
    contentType: models.ContentType.contentTypeClaim,
    content: protocol.Claim(
      claimType: "Occupation",
      claim: protocol.ClaimOccupation(
        organization: organization,
        role: role,
        location: location,
      ).writeToBuffer(),
    ).writeToBuffer(),
  );

  final pointer = await saveEvent(transaction, processInfo, event);

  return ClaimInfo("Occupation", organization, pointer);
}

Future<void> makeVouch(sqflite.Transaction transaction,
    ProcessSecret processInfo, protocol.Pointer pointer) async {
  final protocol.Event event = protocol.Event(
    contentType: models.ContentType.contentTypeVouch,
    references: [
      protocol.Reference(
        referenceType: fixnum.Int64(2),
        reference: pointer.writeToBuffer(),
      ),
    ],
  );

  await saveEvent(transaction, processInfo, event);
}

Future<void> main() async {
  FlutterCryptography.enable();
  WidgetsFlutterBinding.ensureInitialized();

  final provider = await setupModel();
  await provider.mLoadIdentities();

  runApp(NeopassApp(polycentricModel: provider));
}

MaterialColor makeColor(Color color) {
  final Map<int, Color> shades = {};

  for (int i = 1; i < 20; i++) {
    shades[50 * i] = color;
  }

  return MaterialColor(color.value, shades);
}

final MaterialColor buttonColor = makeColor(const Color(0xFF1B1B1B));
final MaterialColor blueButtonColor = makeColor(const Color(0xFF2D63ED));
final MaterialColor formColor = makeColor(const Color(0xFF303030));
final MaterialColor tokenColor = makeColor(const Color(0xFF141414));
final MaterialColor deleteColor = makeColor(const Color(0xFF2F2F2F));

class ClaimInfo {
  final String claimType;
  final String text;
  final protocol.Pointer pointer;

  ClaimInfo(this.claimType, this.text, this.pointer);
}

class ProcessInfo {
  final ProcessSecret processSecret;
  final String username;
  final List<ClaimInfo> claims;
  final Image? avatar;
  final String description;

  ProcessInfo(
    this.processSecret,
    this.username,
    this.claims,
    this.avatar,
    this.description,
  );
}

class PolycentricModel extends ChangeNotifier {
  final sqflite.Database db;
  List<ProcessInfo> identities = [];

  PolycentricModel(this.db);

  Future<void> mLoadIdentities() async {
    final identities = await loadIdentities(db);
    this.identities = [];
    for (final identity in identities) {
      final public = await identity.system.extractPublicKey();

      await db.transaction((transaction) async {
        final username = await loadLatestUsername(
          transaction,
          public.bytes,
        );

        final description = await loadLatestDescription(
          transaction,
          public.bytes,
        );

        final avatar = await loadLatestAvatar(
          transaction,
          public.bytes,
        );

        final claims = await loadClaims(transaction, public.bytes);

        this.identities.add(
              ProcessInfo(identity, username, claims, avatar, description),
            );
      });

      // blah
      final systemProto = protocol.PublicKey();
      systemProto.keyType = fixnum.Int64(1);
      systemProto.key = public.bytes;

      await synchronizer.backfillClient(
          db, systemProto, 'https://srv1-stg.polycentric.io');
    }

    notifyListeners();
  }
}

Future<PolycentricModel> setupModel() async {
  return PolycentricModel(await queries.createDB('neopass14.db'));
}

class NeopassApp extends StatelessWidget {
  final PolycentricModel polycentricModel;
  const NeopassApp({Key? key, required this.polycentricModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialPage = polycentricModel.identities.isEmpty
        ? const NewOrImportProfilePage()
        : const NewOrImportProfilePage();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PolycentricModel>(
          create: (context) => polycentricModel,
        ),
      ],
      child: MaterialApp(
        title: 'Harbor',
        theme: ThemeData(
          primarySwatch: buttonColor,
          canvasColor: const Color(0xFF000000),
        ),
        home: initialPage,
      ),
    );
  }
}

final Widget neopassLogoAndText = Column(
  children: [
    Image.asset('assets/logo.png'),
    const SizedBox(height: 20),
    const Text(
      'NeoPass',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'inter',
        fontWeight: FontWeight.w300,
        fontSize: 32,
        color: Colors.white,
      ),
    ),
  ],
);

final Widget futoLogoAndText = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset('assets/futo-logo.png'),
    const SizedBox(width: 10),
    Image.asset('assets/futo-text.png'),
  ],
);

class ClaimButtonGeneric extends StatelessWidget {
  final String nameText;
  final void Function() onPressed;
  final StatelessWidget top;

  const ClaimButtonGeneric({
    Key? key,
    required this.nameText,
    required this.onPressed,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            top,
            Text(
              nameText,
              style: const TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClaimButtonIcon extends StatelessWidget {
  final String nameText;
  final IconData icon;
  final void Function() onPressed;

  const ClaimButtonIcon({
    Key? key,
    required this.nameText,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClaimButtonGeneric(
      nameText: nameText,
      onPressed: onPressed,
      top: Icon(
        icon,
        size: 50,
        semanticLabel: nameText,
        color: Colors.white,
      ),
    );
  }
}

class ClaimButtonImage extends StatelessWidget {
  final String nameText;
  final Image image;
  final void Function() onPressed;

  const ClaimButtonImage({
    Key? key,
    required this.nameText,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClaimButtonGeneric(
      nameText: nameText,
      onPressed: onPressed,
      top: Container(
        child: image,
      ),
    );
  }
}

class StandardButtonGeneric extends StatelessWidget {
  final String actionText;
  final String actionDescription;
  final Widget left;
  final void Function() onPressed;
  final void Function()? onDelete;

  const StandardButtonGeneric({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.left,
    required this.onPressed,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = [
      const SizedBox(width: 10),
      SizedBox(
        width: 50,
        height: 50,
        child: left,
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(actionText,
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white)),
              Text(actionDescription,
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    ];

    if (onDelete != null) {
      rowChildren.add(
        SizedBox(
          height: 50,
          width: 50,
          child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: deleteColor,
                textStyle: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    bottomLeft: Radius.zero,
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
              onPressed: onDelete,
              child: const Text("Delete")),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.black,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: Row(
                children: rowChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StandardButton extends StatelessWidget {
  final String actionText;
  final String actionDescription;
  final IconData icon;
  final void Function() onPressed;

  const StandardButton({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardButtonGeneric(
      actionText: actionText,
      actionDescription: actionDescription,
      onPressed: onPressed,
      left: Icon(
        icon,
        size: 50,
        semanticLabel: actionText,
        color: Colors.white,
      ),
    );
  }
}

Icon makeButtonIcon(IconData icon, String actionText) {
  return Icon(
    icon,
    size: 40,
    semanticLabel: actionText,
    color: Colors.white,
  );
}

Image makeButtonImage(String path) {
  return Image.asset(path);
}

Widget claimTypeToVisual(String claimType) {
  switch (claimType) {
    case "Generic":
      {
        return makeButtonIcon(Icons.format_quote, claimType);
      }
    case "Skill":
      {
        return makeButtonIcon(Icons.build, claimType);
      }
    case "Occupation":
      {
        return makeButtonIcon(Icons.work, claimType);
      }
    case "YouTube":
      {
        return makeButtonImage('assets/youtube.png');
      }
    case "Odysee":
      {
        return makeButtonImage('assets/odysee.png');
      }
    case "Rumble":
      {
        return makeButtonImage('assets/rumble.png');
      }
    case "Twitch":
      {
        return makeButtonImage('assets/twitch.png');
      }
    case "Instagram":
      {
        return makeButtonImage('assets/instagram.png');
      }
    case "Minds":
      {
        return makeButtonImage('assets/Minds.png');
      }
    case "Twitter":
      {
        return makeButtonImage('assets/twitter.png');
      }
    case "Discord":
      {
        return makeButtonImage('assets/discord.png');
      }
    case "Patreon":
      {
        return makeButtonImage('assets/patreon.png');
      }
  }

  throw Exception("unknown claim type");
}

Image claimTypeToImage(String claimType) {
  switch (claimType) {
    case "YouTube":
      {
        return Image.asset('assets/youtube.png');
      }
    case "Odysee":
      {
        return Image.asset('assets/odysee.png');
      }
    case "Rumble":
      {
        return Image.asset('assets/rumble.png');
      }
    case "Twitch":
      {
        return Image.asset('assets/twitch.png');
      }
    case "Instagram":
      {
        return Image.asset('assets/instagram.png');
      }
    case "Minds":
      {
        return Image.asset('assets/minds.png');
      }
    case "Twitter":
      {
        return Image.asset('assets/twitter.png');
      }
    case "Discord":
      {
        return Image.asset('assets/discord.png');
      }
    case "Patreon":
      {
        return Image.asset('assets/patreon.png');
      }
  }

  throw Exception("unknown claim type");
}

Text makeAppBarTitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'inter',
      fontSize: 24,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    ),
  );
}

const scaffoldPadding = EdgeInsets.only(left: 10.0, right: 10.0);

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String label;

  const LabeledTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'inter',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        maxLines: 1,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          fillColor: formColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    ]);
  }
}
