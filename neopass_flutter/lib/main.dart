import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'package:fixnum/fixnum.dart' as fixnum;

import 'pages/new_or_import_profile.dart';
import 'models.dart' as models;
import 'protocol.pb.dart' as protocol;
import 'synchronizer.dart' as synchronizer;
import 'queries.dart' as queries;
import 'shared_ui.dart' as shared_ui;
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
    final processInfo = await importIdentity(transaction, keyPair);

    await setServer(
      transaction,
      processInfo,
      protocol.LWWElementSet_Operation.ADD,
      'https://srv1-stg.polycentric.io',
    );

    return processInfo;
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

  final events = protocol.Events();

  await db.transaction((transaction) async {
    final usernameSignedEvent = await queries.loadLatestCRDTByContentType(
      transaction,
      publicKey,
      models.ContentType.contentTypeUsername,
    );

    if (usernameSignedEvent != null) {
      events.events.add(usernameSignedEvent);
    }

    final serverSignedEvents =
        await queries.loadLatestCRDTSetItemsByContentType(
      transaction,
      publicKey,
      models.ContentType.contentTypeServer,
    );

    events.events.addAll(serverSignedEvents);
  });

  final exportBundle = protocol.ExportBundle(
    keyPair: protocol.KeyPair(
      keyType: fixnum.Int64(1),
      privateKey: privateKey,
      publicKey: publicKey,
    ),
    events: events,
  );

  return "polycentric://${base64.encode(exportBundle.writeToBuffer())}";
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

  if (event.hasLwwElementSet()) {
    await queries.insertCRDTSetItem(transaction, eventId, event.lwwElementSet);
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
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    final pointer = await signedEventToPointer(signedEvent);

    result.add(ClaimInfo(pointer, event));
  }

  return result;
}

Future<List<String>> loadServerList(
  sqflite.Transaction transaction,
  List<int> system,
) async {
  final signedEvents = await queries.loadLatestCRDTSetItemsByContentType(
    transaction,
    system,
    models.ContentType.contentTypeServer,
  );

  final List<String> result = [];

  for (final signedEvent in signedEvents) {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    if (!event.hasLwwElementSet()) {
      logger.d("expected hasLWWElementSet");

      continue;
    }

    if (event.contentType != models.ContentType.contentTypeServer) {
      logger
          .d("expected server event but got: ${event.contentType.toString()}");

      continue;
    }

    if (event.lwwElementSet.operation != protocol.LWWElementSet_Operation.ADD) {
      logger.d("expected ADD operation");

      continue;
    }

    result.add(utf8.decode(event.lwwElementSet.value));
  }

  return result;
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

  final protocol.PublicKey system = protocol.PublicKey(
    keyType: fixnum.Int64(1),
    key: public.bytes,
  );

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

Future<void> setCRDTSetItem(
    sqflite.Transaction transaction,
    ProcessSecret processInfo,
    fixnum.Int64 contentType,
    protocol.LWWElementSet_Operation operation,
    Uint8List value) async {
  final protocol.Event event = protocol.Event(
    contentType: contentType,
    lwwElementSet: protocol.LWWElementSet(
      unixMilliseconds: fixnum.Int64(DateTime.now().millisecondsSinceEpoch),
      value: value,
      operation: operation,
    ),
  );

  await saveEvent(transaction, processInfo, event);
}

Future<void> setServer(
  sqflite.Transaction transaction,
  ProcessSecret processInfo,
  protocol.LWWElementSet_Operation operation,
  String server,
) async {
  await setCRDTSetItem(
    transaction,
    processInfo,
    models.ContentType.contentTypeServer,
    operation,
    Uint8List.fromList(utf8.encode(server)),
  );
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

  return ClaimInfo(pointer, event);
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

  return ClaimInfo(pointer, event);
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

class ClaimInfo {
  String claimType = '';
  String text = '';
  final protocol.Pointer pointer;
  final protocol.Event event;
  protocol.ClaimOccupation? claimOccupation;

  ClaimInfo(this.pointer, this.event) {
    final protocol.Claim claim = protocol.Claim.fromBuffer(event.content);

    claimType = claim.claimType;

    if (claim.claimType == 'Occupation') {
      claimOccupation = protocol.ClaimOccupation.fromBuffer(claim.claim);

      text = claimOccupation!.organization;
    } else {
      final protocol.ClaimIdentifier claimIdentifier =
          protocol.ClaimIdentifier.fromBuffer(claim.claim);

      text = claimIdentifier.identifier;
    }
  }
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

      synchronizer.backfillClient(db, systemProto);
      synchronizer.backfillServers(db, systemProto);
    }

    notifyListeners();
  }
}

Future<PolycentricModel> setupModel() async {
  return PolycentricModel(await queries.createDB('neopass16.db'));
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
          primarySwatch: shared_ui.buttonColor,
          canvasColor: const Color(0xFF000000),
          fontFamily: 'inter',
        ),
        home: initialPage,
      ),
    );
  }
}
