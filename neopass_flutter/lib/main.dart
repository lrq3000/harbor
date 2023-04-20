import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as Cryptography;
import 'package:sqflite/sqflite.dart' as SQFLite;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as Path;
import 'package:fixnum/fixnum.dart' as FixNum;

import 'api_methods.dart';
import 'pages/new_or_import_profile.dart';
import 'models.dart' as Models;
import 'protocol.pb.dart' as Protocol;

const SCHEMA_TABLE_EVENTS = '''
CREATE TABLE IF NOT EXISTS events (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    process         BLOB    NOT NULL,
    logical_clock   INTEGER NOT NULL,
    content_type    INTEGER NOT NULL,
    raw_event       BLOB    NOT NULL
);
''';

const SCHEMA_TABLE_PROCESS_SECRETS = '''
CREATE TABLE IF NOT EXISTS process_secrets (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    system_key_pub  BLOB    NOT NULL,
    process         BLOB    NOT NULL
);
''';

const SCHEMA_TABLE_DELETIONS = '''
CREATE TABLE IF NOT EXISTS deletions (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      INTEGER NOT NULL,
    process         BLOB    NOT NULL,
    logical_clock   INTEGER NOT NULL,
    event_id        INTEGER NOT NULL
);
''';

const SCHEMA_TABLE_CRDTS = '''
CREATE TABLE IF NOT EXISTS crdts (
    id                INTEGER PRIMARY KEY,
    unix_milliseconds INTEGER NOT NULL,
    value             BLOB    NOT NULL,
    event_id          INTEGER NOT NULL,

    FOREIGN KEY (event_id)
      REFERENCES events (id)
      ON DELETE CASCADE
);
''';

class ProcessSecret {
  Cryptography.SimpleKeyPair system;
  List<int> process;

  ProcessSecret(this.system, this.process);
}

Future<ProcessSecret> createNewIdentity(SQFLite.Database db) async {
  final algorithm = Cryptography.Ed25519();
  final keyPair = await algorithm.newKeyPair();
  final public = await keyPair.extractPublicKey();

  final privateBytes = await keyPair.extractPrivateKeyBytes();
  final publicBytes = public.bytes;

  final process = List<int>.generate(16, (i) => Random.secure().nextInt(256));

  await db.rawInsert('''
            INSERT INTO process_secrets (
                system_key_type,
                system_key,
                system_key_pub,
                process
            ) VALUES(?, ?, ?, ?);
        ''', [
    1,
    privateBytes,
    publicBytes,
    process,
  ]);

  final publicProto = Protocol.PublicKey();
  publicProto.keyType = FixNum.Int64(1);
  publicProto.key = public.bytes;
  print("new identity");
  print(base64Url.encode(publicProto.writeToBuffer()));

  return ProcessSecret(keyPair, process);
}

Future<List<ProcessSecret>> loadIdentities(SQFLite.Database db) async {
  final List<Map> rows = await db.rawQuery('''
        SELECT * FROM process_secrets;
    ''');

  final result = List<ProcessSecret>.empty(growable: true);

  for (var row in rows) {
    final public = Cryptography.SimplePublicKey(
      row['system_key_pub'],
      type: Cryptography.KeyPairType.ed25519,
    );

    final keyPair = Cryptography.SimpleKeyPairData(
      row['system_key'],
      publicKey: public,
      type: Cryptography.KeyPairType.ed25519,
    );

    result.add(
      ProcessSecret(keyPair, row['process']),
    );
  }

  return result;
}

Future<void> deleteIdentity(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
) async {
  await db.rawDelete('''
        DELETE FROM process_secrets
        WHERE system_key_type = 1
        AND system_key_pub = ?
        AND process = ?;
    ''', [Uint8List.fromList(system), Uint8List.fromList(process)]);
}

Future<bool> isEventDeleted(
  SQFLite.Transaction transaction,
  Protocol.Event event,
) async {
  const QUERY = '''
      SELECT 1 FROM deletions
      WHERE system_key_type = ?
      AND system_key = ?
      AND process = ?
      AND logical_clock = ?
      LIMIT 1;
  ''';

  final rows = await transaction.rawQuery(QUERY, [
    event.system.keyType.toInt(),
    Uint8List.fromList(event.system.key),
    Uint8List.fromList(event.process.process),
    event.logicalClock.toInt(),
  ]);

  return rows.isNotEmpty;
}

Future<void> deleteEventDB(
  SQFLite.Transaction transaction,
  int rowId,
  Protocol.PublicKey system,
  Protocol.Delete deleteBody,
) async {
  const QUERY_INSERT_DELETE = '''
      INSERT INTO deletions
      (
          system_key_type,
          system_key,
          process,
          logical_clock,
          event_id
      )
      VALUES (?, ?, ?, ?, ?);
  ''';

  const QUERY_DELETE_EVENT = '''
      DELETE FROM events
      WHERE system_key_type = ?
      AND system_key = ?
      AND process = ?
      AND logical_clock = ?;
  ''';

  await transaction.rawQuery(QUERY_INSERT_DELETE, [
    system.keyType.toInt(),
    Uint8List.fromList(system.key),
    Uint8List.fromList(deleteBody.process.process),
    deleteBody.logicalClock.toInt(),
    rowId,
  ]);

  await transaction.rawDelete(QUERY_DELETE_EVENT, [
    system.keyType.toInt(),
    Uint8List.fromList(system.key),
    Uint8List.fromList(deleteBody.process.process),
    deleteBody.logicalClock.toInt(),
  ]);
}

Future<void> insertLWWElement(
  SQFLite.Transaction transaction,
  int rowId,
  Protocol.LWWElement element,
) async {
  const QUERY = '''
    INSERT INTO crdts
    (
      unix_milliseconds,
      value,
      event_id
    )
    VALUES (?, ?, ?);
  ''';

  await transaction.rawQuery(QUERY, [
    element.unixMilliseconds.toInt(),
    Uint8List.fromList(element.value),
    rowId,
  ]);
}

Future<void> ingest(
  SQFLite.Transaction transaction,
  Protocol.SignedEvent signedEvent,
) async {
  final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

  final public = Cryptography.SimplePublicKey(
    event.system.key,
    type: Cryptography.KeyPairType.ed25519,
  );

  final signature = Cryptography.Signature(
    signedEvent.signature,
    publicKey: public,
  );

  final validSignature = await Cryptography.Ed25519().verify(
    signedEvent.event,
    signature: signature,
  );

  if (!validSignature) {
    throw 'invalid signature';
  }

  if (await isEventDeleted(transaction, event)) {
    print("event already deleted");
    return;
  }

  final eventId = await transaction.rawInsert('''
            INSERT INTO events (
                system_key_type,
                system_key,
                process,
                logical_clock,
                content_type,
                raw_event
            ) VALUES(?, ?, ?, ?, ?, ?);
        ''', [
    event.system.keyType.toInt(),
    Uint8List.fromList(event.system.key),
    Uint8List.fromList(event.process.process),
    event.logicalClock.toInt(),
    event.contentType.toInt(),
    signedEvent.writeToBuffer(),
  ]);

  if (event.contentType == Models.ContentType.ContentTypeDelete) {
    final Protocol.Delete deleteBody =
        Protocol.Delete.fromBuffer(event.content);

    await deleteEventDB(transaction, eventId, event.system, deleteBody);
  }

  if (event.lwwElement != null) {
    await insertLWWElement(
      transaction, eventId, event.lwwElement);
  }
}

Future<int> loadLatestClock(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
) async {
  final f = SQFLite.Sqflite.firstIntValue(await db.rawQuery('''
        SELECT MAX(logical_clock) as x FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND process = ?;
    ''', [Uint8List.fromList(system), Uint8List.fromList(process)]));

  if (f == null) {
    return 0;
  } else {
    return f + 1;
  }
}

Future<Protocol.Pointer> signedEventToPointer(
    Protocol.SignedEvent signedEvent) async {
  final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

  final hash = await Cryptography.Sha256().hash(signedEvent.event);

  final Protocol.Digest digest = Protocol.Digest();
  digest.digestType = FixNum.Int64(1);
  digest.digest = hash.bytes;

  final Protocol.Pointer pointer = Protocol.Pointer();
  pointer.system = event.system;
  pointer.process = event.process;
  pointer.logicalClock = event.logicalClock;
  pointer.eventDigest = digest;

  return pointer;
}

Future<List<ClaimInfo>> loadClaims(
  SQFLite.Database db,
  List<int> system,
) async {
  final rows = await db.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND content_type = 12;
    ''', [Uint8List.fromList(system)]);

  final List<ClaimInfo> result = [];

  for (final row in rows) {
    final rawEvent = row['raw_event'];

    Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

    Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    Protocol.Claim claim = Protocol.Claim.fromBuffer(event.content);

    Protocol.ClaimIdentifier claimIdentifier =
        Protocol.ClaimIdentifier.fromBuffer(claim.claim);

    final pointer = await signedEventToPointer(signedEvent);

    result.add(ClaimInfo(claim.claimType, claimIdentifier.identifier, pointer));
  }

  return result;
}

Future<void> sendAllEventsToServer(
  SQFLite.Database db,
  List<int> system,
) async {
  final rows = await db.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?;
    ''', [Uint8List.fromList(system)]);

  final Protocol.Events payload = Protocol.Events();

  for (final row in rows) {
    final rawEvent = row['raw_event'];

    final Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

    payload.events.add(signedEvent);
  }

  await postEvents(payload);
}

Future<Protocol.SignedEvent?> loadLatestEventByContentType(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
  FixNum.Int64 contentType,
) async {
  final q = await db.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND process = ?
        AND content_type = ?
        ORDER BY
        logical_clock DESC
        LIMIT 1;
    ''', [
    Uint8List.fromList(system),
    Uint8List.fromList(process),
    contentType.toInt()
  ]);

  if (q.isEmpty) {
    return null;
  } else {
    return Protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);
  }
}

Future<Protocol.SignedEvent?> loadLatestCRDTByContentType(
  SQFLite.Database db,
  List<int> system,
  FixNum.Int64 contentType,
) async {
  final q = await db.rawQuery('''
            SELECT events.raw_event
            FROM
              crdts
            JOIN
              events
            ON
              crdts.event_id = events.id
            WHERE
              events.content_type = ?
            AND
              events.system_key_type = 1
            AND
              events.system_key = ?
            ORDER BY
              crdts.unix_milliseconds DESC
            LIMIT 1
    ''', [
    contentType.toInt(),
    Uint8List.fromList(system)
  ]);

  if (q.isEmpty) {
    return null;
  } else {
    return Protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);
  }
}

Future<String> loadLatestUsername(
  SQFLite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
    system,
    Models.ContentType.ContentTypeUsername,
  );

  if (signedEvent == null) {
    return 'unknown';
  } else {
    final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    return utf8.decode(event.lwwElement.value);
  }
}

Future<String> loadLatestDescription(
  SQFLite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
    system,
    Models.ContentType.ContentTypeDescription,
  );

  if (signedEvent == null) {
    return '';
  } else {
    final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    return utf8.decode(event.lwwElement.value);
  }
}

Future<Protocol.SignedEvent?> loadEvent(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
  FixNum.Int64 logicalClock,
) async {
  final rows = await db.rawQuery('''
    SELECT raw_event FROM events
    WHERE system_key_type = 1
    AND system_key = ?
    AND process = ?
    AND logical_clock = ?
    LIMIT 1;
  ''', [
    Uint8List.fromList(system),
    Uint8List.fromList(process),
    logicalClock.toInt()
  ]);

  if (rows.isNotEmpty) {
    return Protocol.SignedEvent.fromBuffer(
        rows.first["raw_event"] as List<int>);
  }

  return null;
}

Future<Image?> loadImage(
  SQFLite.Database db,
  Protocol.Pointer pointer,
) async {
  final metaSignedEvent = await loadEvent(
    db,
    pointer.system.key,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (metaSignedEvent == null) {
    return null;
  }

  final metaEvent = Protocol.Event.fromBuffer(metaSignedEvent.event);

  if (metaEvent.contentType != Models.ContentType.ContentTypeBlobMeta) {
    print("expected blob meta event");
    print(metaEvent.contentType);

    return null;
  }

  final blobMeta = Protocol.BlobMeta.fromBuffer(metaEvent.content);

  final contentSignedEvent = await loadEvent(
    db,
    metaEvent.system.key,
    metaEvent.process.process,
    metaEvent.logicalClock + 1,
  );

  if (contentSignedEvent == null) {
    return null;
  }

  final contentEvent = Protocol.Event.fromBuffer(contentSignedEvent.event);

  if (contentEvent.contentType != Models.ContentType.ContentTypeBlobSection) {
    print("expected blob section event");

    return null;
  }

  final blobSection = Protocol.BlobSection.fromBuffer(contentEvent.content);

  return Image.memory(Uint8List.fromList(blobSection.content));
}

Future<Image?> loadLatestAvatar(
  SQFLite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
    system,
    Models.ContentType.ContentTypeAvatar,
  );

  if (signedEvent == null) {
    return null;
  } else {
    final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    if (event.contentType != Models.ContentType.ContentTypeAvatar) {
      print("expected content type avatar");

      return null;
    }

    final Protocol.Pointer pointer = Protocol.Pointer.fromBuffer(
      event.lwwElement.value,
    );

    return loadImage(db, pointer);
  }
}

Future<Protocol.Pointer> saveEvent(SQFLite.Database db,
    ProcessSecret processInfo, Protocol.Event event) async {
  final public = await processInfo.system.extractPublicKey();
  final Protocol.PublicKey system = Protocol.PublicKey();
  system.keyType = FixNum.Int64(1);
  system.key = public.bytes;

  final Protocol.Process process = Protocol.Process();
  process.process = processInfo.process;

  final clock = await loadLatestClock(
    db,
    public.bytes,
    processInfo.process,
  );

  print(clock);

  event.system = system;
  event.process = process;
  event.logicalClock = FixNum.Int64(clock);
  event.vectorClock = Protocol.VectorClock();
  event.indices = Protocol.Indices();

  final encoded = event.writeToBuffer();

  final Protocol.SignedEvent signedEvent = Protocol.SignedEvent();
  signedEvent.event = encoded;
  signedEvent.signature = (await Cryptography.Ed25519().sign(
    encoded,
    keyPair: processInfo.system,
  ))
      .bytes;

  await db.transaction((transaction) async {
    await ingest(transaction, signedEvent);
  });

  sendAllEventsToServer(db, public.bytes);

  return await signedEventToPointer(signedEvent);
}

Future<void> deleteEvent(
  SQFLite.Database db,
  ProcessSecret processInfo,
  Protocol.Pointer pointer,
) async {
  final signedEvent = await loadEvent(
    db,
    pointer.system.key,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (signedEvent == null) {
    print("cannot delete event that does not exist");
    return;
  } else {
    final Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    final Protocol.Delete deleteBody = Protocol.Delete();
    deleteBody.process = pointer.process;
    deleteBody.logicalClock = pointer.logicalClock;
    deleteBody.indices = event.indices;

    final Protocol.Event deleteEvent = Protocol.Event();
    deleteEvent.contentType = Models.ContentType.ContentTypeDelete;
    deleteEvent.content = deleteBody.writeToBuffer();

    await saveEvent(db, processInfo, deleteEvent);
  }
}

Future<Protocol.Pointer> publishBlob(SQFLite.Database db,
    ProcessSecret processInfo, String mime, List<int> bytes) async {
  final Protocol.BlobMeta blobMeta = Protocol.BlobMeta();
  blobMeta.sectionCount = FixNum.Int64(1);
  blobMeta.mime = mime;

  final Protocol.Event blobMetaEvent = Protocol.Event();
  blobMetaEvent.contentType = Models.ContentType.ContentTypeBlobMeta;
  blobMetaEvent.content = blobMeta.writeToBuffer();

  final blobMetaPointer = await saveEvent(db, processInfo, blobMetaEvent);

  final Protocol.BlobSection blobSection = Protocol.BlobSection();
  blobSection.metaPointer = blobMetaPointer.logicalClock;
  blobSection.content = bytes;

  final Protocol.Event blobSectionEvent = Protocol.Event();
  blobSectionEvent.contentType = Models.ContentType.ContentTypeBlobSection;
  blobSectionEvent.content = blobSection.writeToBuffer();

  await saveEvent(db, processInfo, blobSectionEvent);

  return blobMetaPointer;
}

Future<void> setCRDT(SQFLite.Database db, ProcessSecret processInfo,
    FixNum.Int64 contentType, Uint8List bytes) async {
  final Protocol.LWWElement element = Protocol.LWWElement();
  element.unixMilliseconds =
      FixNum.Int64(DateTime.now().millisecondsSinceEpoch);
  element.value = bytes;

  final Protocol.Event event = Protocol.Event();
  event.contentType = contentType;
  event.lwwElement = element;

  await saveEvent(db, processInfo, event);
}

Future<void> setAvatar(SQFLite.Database db, ProcessSecret processInfo,
    Protocol.Pointer pointer) async {
  await setCRDT(
    db,
    processInfo,
    Models.ContentType.ContentTypeAvatar,
    pointer.writeToBuffer(),
  );
}

Future<void> setUsername(
    SQFLite.Database db, ProcessSecret processInfo, String username) async {
  await setCRDT(
    db,
    processInfo,
    Models.ContentType.ContentTypeUsername,
    Uint8List.fromList(utf8.encode(username)),
  );
}

Future<void> setDescription(
    SQFLite.Database db, ProcessSecret processInfo, String description) async {
  await setCRDT(
    db,
    processInfo,
    Models.ContentType.ContentTypeDescription,
    Uint8List.fromList(utf8.encode(description)),
  );
}

Future<void> makeClaim(
    SQFLite.Database db, ProcessSecret processInfo, String claimText) async {
  final Protocol.ClaimIdentifier claimIdentifier = Protocol.ClaimIdentifier();
  claimIdentifier.identifier = claimText;

  final Protocol.Claim claim = Protocol.Claim();
  claim.claimType = "Generic";
  claim.claim = claimIdentifier.writeToBuffer();

  final Protocol.Event event = Protocol.Event();
  event.contentType = Models.ContentType.ContentTypeClaim;
  event.content = claim.writeToBuffer();

  await saveEvent(db, processInfo, event);
}

Future<ClaimInfo> makePlatformClaim(SQFLite.Database db,
    ProcessSecret processInfo, String claimType, String account) async {
  final Protocol.ClaimIdentifier claimIdentifier = Protocol.ClaimIdentifier();
  claimIdentifier.identifier = account;

  final Protocol.Claim claim = Protocol.Claim();
  claim.claimType = claimType;
  claim.claim = claimIdentifier.writeToBuffer();

  final Protocol.Event event = Protocol.Event();
  event.contentType = Models.ContentType.ContentTypeClaim;
  event.content = claim.writeToBuffer();

  final pointer = await saveEvent(db, processInfo, event);

  return ClaimInfo(claimType, account, pointer);
}

Future<ClaimInfo> makeOccupationClaim(
    SQFLite.Database db,
    ProcessSecret processInfo,
    String organization,
    String role,
    String location) async {
  final Protocol.ClaimOccupation claimOccupation = Protocol.ClaimOccupation();
  claimOccupation.organization = organization;
  claimOccupation.role = role;
  claimOccupation.location = location;

  final Protocol.Claim claim = Protocol.Claim();
  claim.claimType = "Occupation";
  claim.claim = claimOccupation.writeToBuffer();

  final Protocol.Event event = Protocol.Event();
  event.contentType = Models.ContentType.ContentTypeClaim;
  event.content = claim.writeToBuffer();

  final pointer = await saveEvent(db, processInfo, event);

  return ClaimInfo("Occupation", organization, pointer);
}

Future<void> makeVouch(SQFLite.Database db, ProcessSecret processInfo,
    Protocol.Pointer pointer) async {
  final Protocol.Reference reference = Protocol.Reference();
  reference.referenceType = FixNum.Int64(2);
  reference.reference = pointer.writeToBuffer();

  final Protocol.Event event = Protocol.Event();
  event.contentType = Models.ContentType.ContentTypeVouch;
  event.references.add(reference);

  await saveEvent(db, processInfo, event);
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
  final Protocol.Pointer pointer;

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
  final SQFLite.Database db;
  List<ProcessInfo> identities = [];

  PolycentricModel(this.db);

  Future<void> mLoadIdentities() async {
    final identities = await loadIdentities(db);
    this.identities = [];
    for (final identity in identities) {
      final public = await identity.system.extractPublicKey();
      final username = await loadLatestUsername(
        db,
        public.bytes,
      );
      final description = await loadLatestDescription(
        db,
        public.bytes,
      );
      final avatar = await loadLatestAvatar(
        db,
        public.bytes,
      );
      final claims = await loadClaims(db, public.bytes);

      this.identities.add(
            ProcessInfo(identity, username, claims, avatar, description),
          );
    }

    notifyListeners();
  }
}

Future<PolycentricModel> setupModel() async {
  final db = await SQFLite.openDatabase(
    Path.join(await SQFLite.getDatabasesPath(), 'neopass13.db'),
    onCreate: (db, version) async {
      await db.execute(SCHEMA_TABLE_EVENTS);
      await db.execute(SCHEMA_TABLE_PROCESS_SECRETS);
      await db.execute(SCHEMA_TABLE_DELETIONS);
      await db.execute(SCHEMA_TABLE_CRDTS);
    },
    version: 1,
  );

  return PolycentricModel(db);
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

final StatelessWidget neopassLogoAndText = Container(
  child: Column(
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
  ),
);

final StatelessWidget futoLogoAndText = Container(
    child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset('assets/futo-logo.png'),
    const SizedBox(width: 10),
    Image.asset('assets/futo-text.png'),
  ],
));

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
              ),
              child: const Text("Delete"),
              onPressed: onDelete),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
      break;
    case "Skill":
      {
        return makeButtonIcon(Icons.build, claimType);
      }
      break;
    case "Occupation":
      {
        return makeButtonIcon(Icons.work, claimType);
      }
      break;
    case "YouTube":
      {
        return makeButtonImage('assets/youtube.png');
      }
      break;
    case "Odysee":
      {
        return makeButtonImage('assets/odysee.png');
      }
      break;
    case "Rumble":
      {
        return makeButtonImage('assets/rumble.png');
      }
      break;
    case "Twitch":
      {
        return makeButtonImage('assets/twitch.png');
      }
      break;
    case "Instagram":
      {
        return makeButtonImage('assets/instagram.png');
      }
      break;
    case "Minds":
      {
        return makeButtonImage('assets/Minds.png');
      }
      break;
    case "Twitter":
      {
        return makeButtonImage('assets/twitter.png');
      }
      break;
    case "Discord":
      {
        return makeButtonImage('assets/discord.png');
      }
      break;
    case "Patreon":
      {
        return makeButtonImage('assets/patreon.png');
      }
      break;
  }

  throw Exception("unknown claim type");
}

Image claimTypeToImage(String claimType) {
  switch (claimType) {
    case "YouTube":
      {
        return Image.asset('assets/youtube.png');
      }
      break;
    case "Odysee":
      {
        return Image.asset('assets/odysee.png');
      }
      break;
    case "Rumble":
      {
        return Image.asset('assets/rumble.png');
      }
      break;
    case "Twitch":
      {
        return Image.asset('assets/twitch.png');
      }
      break;
    case "Instagram":
      {
        return Image.asset('assets/instagram.png');
      }
      break;
    case "Minds":
      {
        return Image.asset('assets/minds.png');
      }
      break;
    case "Twitter":
      {
        return Image.asset('assets/twitter.png');
      }
      break;
    case "Discord":
      {
        return Image.asset('assets/discord.png');
      }
      break;
    case "Patreon":
      {
        return Image.asset('assets/patreon.png');
      }
      break;
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
