import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:fixnum/fixnum.dart' as fixnum;

import 'api_methods.dart';
import 'pages/new_or_import_profile.dart';
import 'models.dart' as models;
import 'protocol.pb.dart' as protocol;
import 'logger.dart';

const schemaTableEvents = '''
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

const schemaTableProcessSecrets = '''
CREATE TABLE IF NOT EXISTS process_secrets (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    system_key_pub  BLOB    NOT NULL,
    process         BLOB    NOT NULL
);
''';

const schemaTableDeletions = '''
CREATE TABLE IF NOT EXISTS deletions (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      INTEGER NOT NULL,
    process         BLOB    NOT NULL,
    logical_clock   INTEGER NOT NULL,
    event_id        INTEGER NOT NULL
);
''';

const schemaTableCRDTs = '''
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
  cryptography.SimpleKeyPair system;
  List<int> process;

  ProcessSecret(this.system, this.process);
}

Future<ProcessSecret> createNewIdentity(sqflite.Database db) async {
  final algorithm = cryptography.Ed25519();
  final keyPair = await algorithm.newKeyPair();
  return await importIdentity(db, keyPair);
}

Future<ProcessSecret> importIdentity(
  sqflite.Database db,
  cryptography.SimpleKeyPair keyPair,
) async {
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

  final publicProto = protocol.PublicKey();
  publicProto.keyType = fixnum.Int64(1);
  publicProto.key = public.bytes;

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

Future<protocol.ExportBundle> makeExportBundle(
  sqflite.Database db,
  ProcessSecret processSecret,
) async {
  final privateKey = await processSecret.system.extractPrivateKeyBytes();
  final publicKey = (await processSecret.system.extractPublicKey()).bytes;

  final events = protocol.Events();

  final keyPair = protocol.KeyPair();
  keyPair.keyType = fixnum.Int64(1);
  keyPair.privateKey = privateKey;
  keyPair.publicKey = publicKey;

  final exportBundle = protocol.ExportBundle();
  exportBundle.keyPair = keyPair;
  exportBundle.events = events;

  return exportBundle;
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

  await importIdentity(db, keyPair);

  await db.transaction((transaction) async {
    for (final event in exportBundle.events.events) {
      await ingest(transaction, event);
    }
  });
}

Future<void> deleteIdentity(
  sqflite.Database db,
  List<int> system,
  List<int> process,
) async {
  const query = '''
      DELETE FROM process_secrets
      WHERE system_key_type = 1
      AND system_key_pub = ?
      AND process = ?;
  ''';

  await db.rawDelete(
      query, [Uint8List.fromList(system), Uint8List.fromList(process)]);
}

Future<bool> isEventDeleted(
  sqflite.Transaction transaction,
  protocol.Event event,
) async {
  const query = '''
      SELECT 1 FROM deletions
      WHERE system_key_type = ?
      AND system_key = ?
      AND process = ?
      AND logical_clock = ?
      LIMIT 1;
  ''';

  final rows = await transaction.rawQuery(query, [
    event.system.keyType.toInt(),
    Uint8List.fromList(event.system.key),
    Uint8List.fromList(event.process.process),
    event.logicalClock.toInt(),
  ]);

  return rows.isNotEmpty;
}

Future<void> deleteEventDB(
  sqflite.Transaction transaction,
  int rowId,
  protocol.PublicKey system,
  protocol.Delete deleteBody,
) async {
  const queryInsertDelete = '''
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

  const queryDeleteEvent = '''
      DELETE FROM events
      WHERE system_key_type = ?
      AND system_key = ?
      AND process = ?
      AND logical_clock = ?;
  ''';

  await transaction.rawQuery(queryInsertDelete, [
    system.keyType.toInt(),
    Uint8List.fromList(system.key),
    Uint8List.fromList(deleteBody.process.process),
    deleteBody.logicalClock.toInt(),
    rowId,
  ]);

  await transaction.rawDelete(queryDeleteEvent, [
    system.keyType.toInt(),
    Uint8List.fromList(system.key),
    Uint8List.fromList(deleteBody.process.process),
    deleteBody.logicalClock.toInt(),
  ]);
}

Future<void> insertLWWElement(
  sqflite.Transaction transaction,
  int rowId,
  protocol.LWWElement element,
) async {
  const query = '''
    INSERT INTO crdts
    (
      unix_milliseconds,
      value,
      event_id
    )
    VALUES (?, ?, ?);
  ''';

  await transaction.rawQuery(query, [
    element.unixMilliseconds.toInt(),
    Uint8List.fromList(element.value),
    rowId,
  ]);
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

  if (await isEventDeleted(transaction, event)) {
    logger.d("event already deleted");
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

  if (event.contentType == models.ContentType.contentTypeDelete) {
    final protocol.Delete deleteBody =
        protocol.Delete.fromBuffer(event.content);

    await deleteEventDB(transaction, eventId, event.system, deleteBody);
  }

  if (event.hasLwwElement()) {
    await insertLWWElement(transaction, eventId, event.lwwElement);
  }
}

Future<int> loadLatestClock(
  sqflite.Database db,
  List<int> system,
  List<int> process,
) async {
  final f = sqflite.Sqflite.firstIntValue(await db.rawQuery('''
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

Future<protocol.Pointer> signedEventToPointer(
    protocol.SignedEvent signedEvent) async {
  final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

  final hash = await cryptography.Sha256().hash(signedEvent.event);

  final protocol.Digest digest = protocol.Digest();
  digest.digestType = fixnum.Int64(1);
  digest.digest = hash.bytes;

  final protocol.Pointer pointer = protocol.Pointer();
  pointer.system = event.system;
  pointer.process = event.process;
  pointer.logicalClock = event.logicalClock;
  pointer.eventDigest = digest;

  return pointer;
}

Future<List<ClaimInfo>> loadClaims(
  sqflite.Database db,
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

    protocol.SignedEvent signedEvent =
        protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

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
  sqflite.Database db,
  List<int> system,
) async {
  final rows = await db.rawQuery('''
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

Future<protocol.SignedEvent?> loadLatestEventByContentType(
  sqflite.Database db,
  List<int> system,
  List<int> process,
  fixnum.Int64 contentType,
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
    return protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);
  }
}

Future<protocol.SignedEvent?> loadLatestCRDTByContentType(
  sqflite.Database db,
  List<int> system,
  fixnum.Int64 contentType,
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
    ''', [contentType.toInt(), Uint8List.fromList(system)]);

  if (q.isEmpty) {
    return null;
  } else {
    return protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);
  }
}

Future<String> loadLatestUsername(
  sqflite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
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
  sqflite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
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

Future<protocol.SignedEvent?> loadEvent(
  sqflite.Database db,
  List<int> system,
  List<int> process,
  fixnum.Int64 logicalClock,
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
    return protocol.SignedEvent.fromBuffer(
        rows.first["raw_event"] as List<int>);
  }

  return null;
}

Future<Image?> loadImage(
  sqflite.Database db,
  protocol.Pointer pointer,
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

  final metaEvent = protocol.Event.fromBuffer(metaSignedEvent.event);

  if (metaEvent.contentType != models.ContentType.contentTypeBlobMeta) {
    logger.d(
        "expected blob meta event but got: ${metaEvent.contentType.toString()}");

    return null;
  }

  // final blobMeta = Protocol.BlobMeta.fromBuffer(metaEvent.content);

  final contentSignedEvent = await loadEvent(
    db,
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
  sqflite.Database db,
  List<int> system,
) async {
  final signedEvent = await loadLatestCRDTByContentType(
    db,
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

    return loadImage(db, pointer);
  }
}

Future<protocol.Pointer> saveEvent(sqflite.Database db,
    ProcessSecret processInfo, protocol.Event event) async {
  final public = await processInfo.system.extractPublicKey();
  final protocol.PublicKey system = protocol.PublicKey();
  system.keyType = fixnum.Int64(1);
  system.key = public.bytes;

  final protocol.Process process = protocol.Process();
  process.process = processInfo.process;

  final clock = await loadLatestClock(
    db,
    public.bytes,
    processInfo.process,
  );

  logger.d(clock);

  event.system = system;
  event.process = process;
  event.logicalClock = fixnum.Int64(clock);
  event.vectorClock = protocol.VectorClock();
  event.indices = protocol.Indices();

  final encoded = event.writeToBuffer();

  final protocol.SignedEvent signedEvent = protocol.SignedEvent();
  signedEvent.event = encoded;
  signedEvent.signature = (await cryptography.Ed25519().sign(
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
  sqflite.Database db,
  ProcessSecret processInfo,
  protocol.Pointer pointer,
) async {
  final signedEvent = await loadEvent(
    db,
    pointer.system.key,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (signedEvent == null) {
    logger.d("cannot delete event that does not exist");
    return;
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    final protocol.Delete deleteBody = protocol.Delete();
    deleteBody.process = pointer.process;
    deleteBody.logicalClock = pointer.logicalClock;
    deleteBody.indices = event.indices;

    final protocol.Event deleteEvent = protocol.Event();
    deleteEvent.contentType = models.ContentType.contentTypeDelete;
    deleteEvent.content = deleteBody.writeToBuffer();

    await saveEvent(db, processInfo, deleteEvent);
  }
}

Future<protocol.Pointer> publishBlob(sqflite.Database db,
    ProcessSecret processInfo, String mime, List<int> bytes) async {
  final protocol.BlobMeta blobMeta = protocol.BlobMeta();
  blobMeta.sectionCount = fixnum.Int64(1);
  blobMeta.mime = mime;

  final protocol.Event blobMetaEvent = protocol.Event();
  blobMetaEvent.contentType = models.ContentType.contentTypeBlobMeta;
  blobMetaEvent.content = blobMeta.writeToBuffer();

  final blobMetaPointer = await saveEvent(db, processInfo, blobMetaEvent);

  final protocol.BlobSection blobSection = protocol.BlobSection();
  blobSection.metaPointer = blobMetaPointer.logicalClock;
  blobSection.content = bytes;

  final protocol.Event blobSectionEvent = protocol.Event();
  blobSectionEvent.contentType = models.ContentType.contentTypeBlobSection;
  blobSectionEvent.content = blobSection.writeToBuffer();

  await saveEvent(db, processInfo, blobSectionEvent);

  return blobMetaPointer;
}

Future<void> setCRDT(sqflite.Database db, ProcessSecret processInfo,
    fixnum.Int64 contentType, Uint8List bytes) async {
  final protocol.LWWElement element = protocol.LWWElement();
  element.unixMilliseconds =
      fixnum.Int64(DateTime.now().millisecondsSinceEpoch);
  element.value = bytes;

  final protocol.Event event = protocol.Event();
  event.contentType = contentType;
  event.lwwElement = element;

  await saveEvent(db, processInfo, event);
}

Future<void> setAvatar(sqflite.Database db, ProcessSecret processInfo,
    protocol.Pointer pointer) async {
  await setCRDT(
    db,
    processInfo,
    models.ContentType.contentTypeAvatar,
    pointer.writeToBuffer(),
  );
}

Future<void> setUsername(
    sqflite.Database db, ProcessSecret processInfo, String username) async {
  await setCRDT(
    db,
    processInfo,
    models.ContentType.contentTypeUsername,
    Uint8List.fromList(utf8.encode(username)),
  );
}

Future<void> setDescription(
    sqflite.Database db, ProcessSecret processInfo, String description) async {
  await setCRDT(
    db,
    processInfo,
    models.ContentType.contentTypeDescription,
    Uint8List.fromList(utf8.encode(description)),
  );
}

Future<void> makeClaim(
    sqflite.Database db, ProcessSecret processInfo, String claimText) async {
  final protocol.ClaimIdentifier claimIdentifier = protocol.ClaimIdentifier();
  claimIdentifier.identifier = claimText;

  final protocol.Claim claim = protocol.Claim();
  claim.claimType = "Generic";
  claim.claim = claimIdentifier.writeToBuffer();

  final protocol.Event event = protocol.Event();
  event.contentType = models.ContentType.contentTypeClaim;
  event.content = claim.writeToBuffer();

  await saveEvent(db, processInfo, event);
}

Future<ClaimInfo> makePlatformClaim(sqflite.Database db,
    ProcessSecret processInfo, String claimType, String account) async {
  final protocol.ClaimIdentifier claimIdentifier = protocol.ClaimIdentifier();
  claimIdentifier.identifier = account;

  final protocol.Claim claim = protocol.Claim();
  claim.claimType = claimType;
  claim.claim = claimIdentifier.writeToBuffer();

  final protocol.Event event = protocol.Event();
  event.contentType = models.ContentType.contentTypeClaim;
  event.content = claim.writeToBuffer();

  final pointer = await saveEvent(db, processInfo, event);

  return ClaimInfo(claimType, account, pointer);
}

Future<ClaimInfo> makeOccupationClaim(
    sqflite.Database db,
    ProcessSecret processInfo,
    String organization,
    String role,
    String location) async {
  final protocol.ClaimOccupation claimOccupation = protocol.ClaimOccupation();
  claimOccupation.organization = organization;
  claimOccupation.role = role;
  claimOccupation.location = location;

  final protocol.Claim claim = protocol.Claim();
  claim.claimType = "Occupation";
  claim.claim = claimOccupation.writeToBuffer();

  final protocol.Event event = protocol.Event();
  event.contentType = models.ContentType.contentTypeClaim;
  event.content = claim.writeToBuffer();

  final pointer = await saveEvent(db, processInfo, event);

  return ClaimInfo("Occupation", organization, pointer);
}

Future<void> makeVouch(sqflite.Database db, ProcessSecret processInfo,
    protocol.Pointer pointer) async {
  final protocol.Reference reference = protocol.Reference();
  reference.referenceType = fixnum.Int64(2);
  reference.reference = pointer.writeToBuffer();

  final protocol.Event event = protocol.Event();
  event.contentType = models.ContentType.contentTypeVouch;
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
  final db = await sqflite.openDatabase(
    path.join(await sqflite.getDatabasesPath(), 'neopass13.db'),
    onCreate: (db, version) async {
      await db.execute(schemaTableEvents);
      await db.execute(schemaTableProcessSecrets);
      await db.execute(schemaTableDeletions);
      await db.execute(schemaTableCRDTs);
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
