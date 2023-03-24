import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as Cryptography;
import 'package:sqflite/sqflite.dart' as SQFLite;
import 'package:convert/convert.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as Path;
import 'package:fixnum/fixnum.dart' as FixNum;
import 'package:file_picker/file_picker.dart' as FilePicker;
import 'package:http/http.dart' as HTTP;
import 'dart:io';

import 'protocol.pb.dart' as Protocol;

final SCHEMA_TABLE_EVENTS = '''
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

final SCHEMA_TABLE_PROCESS_SECRETS = '''
CREATE TABLE IF NOT EXISTS process_secrets (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    system_key_pub  BLOB    NOT NULL,
    process         BLOB    NOT NULL
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
  publicProto.keyType = new FixNum.Int64(1);
  publicProto.key = public.bytes;
  print("new identity");
  print(base64Url.encode(publicProto.writeToBuffer()));

  return new ProcessSecret(keyPair, process);
}

Future<List<ProcessSecret>> loadIdentities(SQFLite.Database db) async {
  final List<Map> rows = await db.rawQuery('''
        SELECT * FROM process_secrets;
    ''');

  var result = new List<ProcessSecret>.empty(growable: true);

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
      new ProcessSecret(keyPair, row['process']),
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

Future<void> ingest(
  SQFLite.Database db,
  Protocol.SignedEvent signedEvent,
) async {
  Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

  final public = Cryptography.SimplePublicKey(
    event.system.key,
    type: Cryptography.KeyPairType.ed25519,
  );

  final signature = new Cryptography.Signature(
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

  await db.rawInsert('''
            INSERT INTO events (
                system_key_type,
                system_key,
                process,
                logical_clock,
                content_type,
                raw_event
            ) VALUES(?, ?, ?, ?, ?, ?);
        ''', [
    1,
    Uint8List.fromList(event.system.key),
    Uint8List.fromList(event.process.process),
    event.logicalClock.toInt(),
    event.contentType.toInt(),
    signedEvent.writeToBuffer(),
  ]);
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
  Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

  final hash = await Cryptography.Sha256().hash(signedEvent.event);

  Protocol.Digest digest = Protocol.Digest();
  digest.digestType = new FixNum.Int64(1);
  digest.digest = hash.bytes;

  Protocol.Pointer pointer = Protocol.Pointer();
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

  List<ClaimInfo> result = [];

  for (final row in rows) {
    final rawEvent = row['raw_event'];

    Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

    Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    Protocol.Claim claim = Protocol.Claim.fromBuffer(event.content);

    Protocol.ClaimIdentifier claimIdentifier =
        Protocol.ClaimIdentifier.fromBuffer(claim.claim);

    final pointer = await signedEventToPointer(signedEvent);

    result.add(new ClaimInfo(claimIdentifier.identifier, pointer));
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

  Protocol.Events payload = Protocol.Events();

  for (final row in rows) {
    final rawEvent = row['raw_event'];

    Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(rawEvent as List<int>);

    payload.events.add(signedEvent);
  }

  try {
    final response = await HTTP.post(
      Uri.parse('https://srv1-stg.polycentric.io/events'),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: payload.writeToBuffer(),
    );

    if (response.statusCode != 200) {
      print('post events failed');
      print(response.statusCode);
      print(response.body);
    }
  } catch (err) {
    print(err);
  }
}

Future<String> loadLatestUsername(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
) async {
  final q = await db.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND process = ?
        AND content_type = 5
        ORDER BY
        logical_clock DESC
        LIMIT 1;
    ''', [Uint8List.fromList(system), Uint8List.fromList(process)]);

  if (q.length == 0) {
    return 'unknown';
  } else {
    Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);

    Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

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

  if (rows.length > 0) {
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

  if (metaEvent.contentType != FixNum.Int64(7)) {
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

  if (contentEvent.contentType != FixNum.Int64(8)) {
    print("expected blob section event");

    return null;
  }

  final blobSection = Protocol.BlobSection.fromBuffer(contentEvent.content);

  return Image.memory(Uint8List.fromList(blobSection.content));
}

Future<Image?> loadLatestAvatar(
  SQFLite.Database db,
  List<int> system,
  List<int> process,
) async {
  final q = await db.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND process = ?
        AND content_type = 9
        ORDER BY
        logical_clock DESC
        LIMIT 1;
    ''', [Uint8List.fromList(system), Uint8List.fromList(process)]);

  if (q.length == 0) {
    return null;
  } else {
    Protocol.SignedEvent signedEvent =
        Protocol.SignedEvent.fromBuffer(q.first['raw_event'] as List<int>);

    Protocol.Event event = Protocol.Event.fromBuffer(signedEvent.event);

    if (event.contentType != FixNum.Int64(9)) {
      print("expected content type avatar");

      return null;
    }
    ;

    final Protocol.Pointer pointer = Protocol.Pointer.fromBuffer(
      event.lwwElement.value,
    );

    return loadImage(db, pointer);
  }
}

Future<Protocol.Pointer> saveEvent(SQFLite.Database db,
    ProcessSecret processInfo, Protocol.Event event) async {
  final public = await processInfo.system.extractPublicKey();
  Protocol.PublicKey system = Protocol.PublicKey();
  system.keyType = new FixNum.Int64(1);
  system.key = public.bytes;

  Protocol.Process process = Protocol.Process();
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

  Protocol.SignedEvent signedEvent = Protocol.SignedEvent();
  signedEvent.event = encoded;
  signedEvent.signature = (await Cryptography.Ed25519().sign(
    encoded,
    keyPair: processInfo.system,
  ))
      .bytes;

  await ingest(db, signedEvent);

  return await signedEventToPointer(signedEvent);
}

Future<Protocol.Pointer> publishBlob(SQFLite.Database db,
    ProcessSecret processInfo, String mime, List<int> bytes) async {
  final Protocol.BlobMeta blobMeta = Protocol.BlobMeta();
  blobMeta.sectionCount = FixNum.Int64(1);
  blobMeta.mime = mime;

  final Protocol.Event blobMetaEvent = Protocol.Event();
  blobMetaEvent.contentType = FixNum.Int64(7);
  blobMetaEvent.content = blobMeta.writeToBuffer();

  final blobMetaPointer = await saveEvent(db, processInfo, blobMetaEvent);

  final Protocol.BlobSection blobSection = Protocol.BlobSection();
  blobSection.metaPointer = blobMetaPointer.logicalClock;
  blobSection.content = bytes;

  final Protocol.Event blobSectionEvent = Protocol.Event();
  blobSectionEvent.contentType = FixNum.Int64(8);
  blobSectionEvent.content = blobSection.writeToBuffer();

  await saveEvent(db, processInfo, blobSectionEvent);

  final public = await processInfo.system.extractPublicKey();
  await sendAllEventsToServer(db, public.bytes);

  return blobMetaPointer;
}

Future<void> setAvatar(SQFLite.Database db, ProcessSecret processInfo,
    Protocol.Pointer pointer) async {
  Protocol.LWWElement element = Protocol.LWWElement();
  element.unixMilliseconds =
      FixNum.Int64(DateTime.now().millisecondsSinceEpoch);
  element.value = pointer.writeToBuffer();

  Protocol.Event event = Protocol.Event();
  event.contentType = FixNum.Int64(9);
  event.lwwElement = element;

  await saveEvent(db, processInfo, event);

  final public = await processInfo.system.extractPublicKey();
  await sendAllEventsToServer(db, public.bytes);
}

Future<void> setUsername(
    SQFLite.Database db, ProcessSecret processInfo, String username) async {
  Protocol.LWWElement element = Protocol.LWWElement();
  element.unixMilliseconds =
      FixNum.Int64(DateTime.now().millisecondsSinceEpoch);
  element.value = utf8.encode(username);

  Protocol.Event event = Protocol.Event();
  event.contentType = FixNum.Int64(5);
  event.lwwElement = element;

  await saveEvent(db, processInfo, event);

  final public = await processInfo.system.extractPublicKey();
  await sendAllEventsToServer(db, public.bytes);
}

Future<void> makeClaim(
    SQFLite.Database db, ProcessSecret processInfo, String claimText) async {
  Protocol.ClaimIdentifier claimIdentifier = Protocol.ClaimIdentifier();
  claimIdentifier.identifier = claimText;

  Protocol.Claim claim = Protocol.Claim();
  claim.claimType = "Generic";
  claim.claim = claimIdentifier.writeToBuffer();

  Protocol.Event event = Protocol.Event();
  event.contentType = FixNum.Int64(12);
  event.content = claim.writeToBuffer();

  await saveEvent(db, processInfo, event);

  final public = await processInfo.system.extractPublicKey();
  await sendAllEventsToServer(db, public.bytes);
}

Future<void> makeVouch(SQFLite.Database db, ProcessSecret processInfo,
    Protocol.Pointer pointer) async {
  Protocol.Reference reference = Protocol.Reference();
  reference.referenceType = FixNum.Int64(2);
  reference.reference = pointer.writeToBuffer();

  Protocol.Event event = Protocol.Event();
  event.contentType = FixNum.Int64(13);
  event.references.add(reference);

  await saveEvent(db, processInfo, event);

  final public = await processInfo.system.extractPublicKey();
  await sendAllEventsToServer(db, public.bytes);
}

Future<void> main() async {
  FlutterCryptography.enable();
  WidgetsFlutterBinding.ensureInitialized();

  final provider = await setupModel();
  await provider.mLoadIdentities();

  runApp(NeopassApp(polycentricModel: provider));
}

MaterialColor makeColor(Color color) {
  Map<int, Color> shades = {};

  for (int i = 1; i < 20; i++) {
    shades[50 * i] = color;
  }

  return MaterialColor(color.value, shades);
}

MaterialColor buttonColor = makeColor(Color(0xFF1B1B1B));
MaterialColor blueButtonColor = makeColor(Color(0xFF2D63ED));
MaterialColor formColor = makeColor(Color(0xFF303030));

const MaterialColor buttonBorder = MaterialColor(0xff6a5a00, <int, Color>{
  50: Color(0xff6a5a00),
  100: Color(0xff6a5a00),
  200: Color(0xff6a5a00),
  300: Color(0xff6a5a00),
  400: Color(0xff6a5a00),
  500: Color(0xff6a5a00),
  600: Color(0xff6a5a00),
  700: Color(0xff6a5a00),
  800: Color(0xff6a5a00),
  900: Color(0xff6a5a00),
});

class ClaimInfo {
  final String text;
  final Protocol.Pointer pointer;

  ClaimInfo(this.text, this.pointer);
}

class ProcessInfo {
  final ProcessSecret processSecret;
  final String username;
  final List<ClaimInfo> claims;
  final Image? avatar;

  ProcessInfo(this.processSecret, this.username, this.claims, this.avatar);
}

class PolycentricModel extends ChangeNotifier {
  final SQFLite.Database db;
  List<ProcessInfo> identities = [];

  PolycentricModel(this.db);

  Future<void> mLoadIdentities() async {
    final identities = await loadIdentities(this.db);
    this.identities = [];
    for (final identity in identities) {
      final public = await identity.system.extractPublicKey();
      final username = await loadLatestUsername(
        this.db,
        public.bytes,
        identity.process,
      );
      final avatar = await loadLatestAvatar(
        this.db,
        public.bytes,
        identity.process,
      );
      final claims = await loadClaims(this.db, public.bytes);

      this.identities.add(
            new ProcessInfo(identity, username, claims, avatar),
          );
    }

    notifyListeners();
  }
}

Future<PolycentricModel> setupModel() async {
  final db = await SQFLite.openDatabase(
    Path.join(await SQFLite.getDatabasesPath(), 'harbor8.db'),
    onCreate: (db, version) async {
      await db.execute(SCHEMA_TABLE_EVENTS);
      await db.execute(SCHEMA_TABLE_PROCESS_SECRETS);
    },
    version: 1,
  );

  return new PolycentricModel(db);
}

class NeopassApp extends StatelessWidget {
  final PolycentricModel polycentricModel;
  const NeopassApp({Key? key, required this.polycentricModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialPage = this.polycentricModel.identities.length == 0
        ? const NewOrImportProfilePage()
        : const NewOrImportProfilePage();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PolycentricModel>(
          create: (context) => this.polycentricModel,
        ),
      ],
      child: MaterialApp(
        title: 'Harbor',
        theme: ThemeData(
          primarySwatch: buttonColor,
          canvasColor: Color(0xFF000000),
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
      SizedBox(height: 20),
      Text(
        'NeoPass',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'NotoSerif',
          height: 1,
          fontSize: 40,
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
    SizedBox(width: 10),
    Image.asset('assets/futo-text.png'),
  ],
));

class ClaimButtonGeneric extends StatelessWidget {
  final String nameText;
  final Function() onPressed;
  final StatelessWidget top;

  const ClaimButtonGeneric({
    Key? key,
    required this.nameText,
    required this.onPressed,
    required this.top,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(5.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          primary: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            top,
            Text(
              nameText,
              style: TextStyle(
                height: 1.2,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class ClaimButtonIcon extends StatelessWidget {
  final String nameText;
  final IconData icon;
  final Function() onPressed;

  const ClaimButtonIcon({
    Key? key,
    required this.nameText,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

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
  final Function() onPressed;

  const ClaimButtonImage({
    Key? key,
    required this.nameText,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

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
  final StatelessWidget left;
  final Function() onPressed;

  const StandardButtonGeneric({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.left,
    required this.onPressed,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          primary: Colors.black,
        ),
        child: Row(
          children: [
            left,
            Container(
              margin: const EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(actionText,
                      style: TextStyle(
                          height: 1.2, fontSize: 12, color: Colors.white)),
                  Text(actionDescription,
                      style: TextStyle(
                          height: 1.2, fontSize: 8, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class StandardButton extends StatelessWidget {
  final String actionText;
  final String actionDescription;
  final IconData icon;
  final Function() onPressed;

  const StandardButton({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

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

class NewOrImportProfilePage extends StatefulWidget {
  const NewOrImportProfilePage({Key? key}) : super(key: key);

  @override
  State<NewOrImportProfilePage> createState() => _NewOrImportProfilePageState();
}

class _NewOrImportProfilePageState extends State<NewOrImportProfilePage> {
  List<StatelessWidget> _renderProfiles(List<ProcessInfo> identities) {
    List<StatelessWidget> result = [];

    for (var i = 0; i < identities.length; i++) {
      result.add(StandardButtonGeneric(
        actionText: identities[i].username,
        actionDescription: 'Sign in to this identity',
        left: Container(
          child: Padding(
            padding: EdgeInsets.all(7),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              foregroundImage: identities[i].avatar != null
                  ? identities[i].avatar!.image
                  : null,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProfilePage(
              identityIndex: i,
            );
          }));
        },
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();

    var listViewChildren = _renderProfiles(state2.identities);

    listViewChildren.addAll([
      StandardButton(
        actionText: 'New Profile',
        actionDescription: 'Generate a new Polycentric Identity',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewProfilePage();
          }));
        },
      ),
      StandardButton(
        actionText: 'Import Existing Profile',
        actionDescription: 'Use an existing Polycentric Identity',
        icon: Icons.arrow_downward,
        onPressed: () async {},
      ),
    ]);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),
          neopassLogoAndText,
          SizedBox(height: 50),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listViewChildren,
            ),
          ),
          SizedBox(height: 50),
          futoLogoAndText,
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),
          neopassLogoAndText,
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Profile Name",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: textController,
                maxLines: 1,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: formColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 120),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: blueButtonColor,
                shape: StadiumBorder(),
              ),
              onPressed: () async {
                final identity = await createNewIdentity(state2.db);
                await setUsername(state2.db, identity, textController.text);
                await state2.mLoadIdentities();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewOrImportProfilePage();
                }));
              },
              child: Text(
                "Create Profile",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          futoLogoAndText,
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final int identityIndex;

  const ProfilePage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<StatelessWidget> _renderClaims(List<ClaimInfo> claims) {
    List<StatelessWidget> result = [];

    for (var i = 0; i < claims.length; i++) {
      result.add(StandardButton(
        actionText: 'Freeform claim',
        actionDescription: claims[i].text,
        icon: Icons.format_quote,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ClaimPage(
              identityIndex: widget.identityIndex,
              claimIndex: i,
            );
          }));
        },
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];

    List<StatelessWidget> listViewChildren = [
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: Text(
          'Claims',
          textAlign: TextAlign.left,
          style: TextStyle(
            height: 1.2,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    ];

    listViewChildren.addAll(_renderClaims(identity2.claims));

    listViewChildren.addAll([
      Container(
        margin: const EdgeInsets.only(left: 20, top: 20),
        child: Text(
          'Other',
          textAlign: TextAlign.left,
          style: TextStyle(
            height: 1.2,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
      StandardButton(
        actionText: 'Make a claim',
        actionDescription: 'Make a new claim for your profile',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateClaimPage(identityIndex: widget.identityIndex);
          }));
        },
      ),
      StandardButton(
        actionText: 'Vouch for a claim',
        actionDescription: 'Vouch for someone elses claim',
        icon: Icons.video_call,
        onPressed: () async {
          try {
            final String rawScan = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", 'cancel', false, ScanMode.QR);
            final List<int> buffer = base64.decode(rawScan);
            final Protocol.Pointer pointer =
                Protocol.Pointer.fromBuffer(buffer);

            await makeVouch(state2.db, identity2.processSecret, pointer);
          } catch (err) {
            print(err);
          }
        },
      ),
      StandardButton(
        actionText: 'Change account',
        actionDescription: 'Switch to a different account',
        icon: Icons.switch_account,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewOrImportProfilePage();
          }));
        },
      ),
      StandardButton(
        actionText: 'Backup',
        actionDescription: 'Make a backup of your identity',
        icon: Icons.save,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BackupPage();
          }));
        },
      ),
      StandardButton(
        actionText: 'Delete account',
        actionDescription: 'Permanently account from this device',
        icon: Icons.delete,
        onPressed: () async {
          final public =
              await identity2.processSecret.system.extractPublicKey();

          await deleteIdentity(
              state2.db, public.bytes, identity2.processSecret.process);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewOrImportProfilePage();
          }));

          await state2.mLoadIdentities();
        },
      ),
    ]);

    return Scaffold(
      body: Column(
        children: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                foregroundImage:
                    identity2.avatar != null ? identity2.avatar!.image : null,
              ),
            ),
            onTap: () async {
              FilePicker.FilePickerResult? result =
                  await FilePicker.FilePicker.platform.pickFiles(
                type: FilePicker.FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );

              if (result != null) {
                final bytes =
                    await File(result.files.single.path!).readAsBytes();

                final pointer = await publishBlob(
                  state2.db,
                  identity2.processSecret,
                  "image/jpeg",
                  bytes,
                );

                await setAvatar(
                  state2.db,
                  identity2.processSecret,
                  pointer,
                );

                print("set avatar");
              }
            },
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 30, top: 10),
              child: Text(
                identity2.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listViewChildren,
            ),
          ),
        ],
      ),
    );
  }
}

class CreateClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateClaimPage> createState() => _CreateClaimPageState();
}

class _CreateClaimPageState extends State<CreateClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Make Claim'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Freeform",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: textController,
            maxLines: null,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              filled: true,
              fillColor: formColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelText: "Type of claim",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueButtonColor,
                  shape: StadiumBorder(),
                ),
                child: Text('Make Claim'),
                onPressed: () async {
                  await makeClaim(
                      state2.db, identity2.processSecret, textController.text);
                  await state2.mLoadIdentities();
                  Navigator.pop(context);
                }),
          ),
          Text(
            "Common",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 123.0 / 106.0,
            children: [
              ClaimButtonIcon(
                nameText: "Affiliation",
                icon: Icons.location_city,
                onPressed: () {},
              ),
              ClaimButtonIcon(
                nameText: "Skill",
                icon: Icons.build,
                onPressed: () {},
              ),
              ClaimButtonIcon(
                nameText: "Job",
                icon: Icons.work,
                onPressed: () {},
              ),
              ClaimButtonIcon(
                nameText: "Education",
                icon: Icons.school,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "Platforms",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 123.0 / 106.0,
            children: [
              ClaimButtonImage(
                nameText: "YouTube",
                image: Image.asset('assets/youtube.png'),
                onPressed: () {},
              ),
              ClaimButtonImage(
                nameText: "Odysee",
                image: Image.asset('assets/odysee.png'),
                onPressed: () {},
              ),
              ClaimButtonImage(
                nameText: "Rumble",
                image: Image.asset('assets/rumble.png'),
                onPressed: () {},
              ),
              ClaimButtonImage(
                nameText: "Twitch",
                image: Image.asset('assets/twitch.png'),
                onPressed: () {},
              ),
              ClaimButtonImage(
                nameText: "Instagram",
                image: Image.asset('assets/instagram.png'),
                onPressed: () {},
              ),
              ClaimButtonIcon(
                nameText: "Minds",
                icon: Icons.language,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClaimPage extends StatefulWidget {
  final int identityIndex;
  final int claimIndex;

  const ClaimPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  Widget _renderVouches(List<String> vouches) {
    return ListView.separated(
      itemCount: vouches.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Text('');
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];
    var claim2 = identity2.claims[widget.claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Claim'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity2.avatar != null ? identity2.avatar!.image : null,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                identity2.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
          Text(
            "Claims",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Freeform",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            claim2.text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Request Verification",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          StandardButton(
            actionText: 'Automated',
            actionDescription:
                'Get an automated authority to vouch for this claim',
            icon: Icons.refresh,
            onPressed: () {},
          ),
          StandardButton(
            actionText: 'Manual',
            actionDescription: 'Get a manual authority to vouch for this claim',
            icon: Icons.refresh,
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PresentPage(
                  identityIndex: widget.identityIndex,
                  claimIndex: widget.claimIndex,
                );
              }));
            },
          ),
        ],
      ),
    );
  }
}

class BackupPage extends StatelessWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          neopassLogoAndText,
          SizedBox(height: 120),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "If you lose this backup you will lose your identity. " +
                  "You will be able to backup your identity at any time. " +
                  "Do not share your identity over an insecure channel.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          StandardButton(
            actionText: 'Share',
            actionDescription: 'Send your identity to another app',
            icon: Icons.share,
            onPressed: () {},
          ),
          StandardButton(
            actionText: 'Copy',
            actionDescription: 'Copy your identity to clipboard',
            icon: Icons.content_copy,
            onPressed: () {},
          ),
          StandardButton(
            actionText: 'QR Code',
            actionDescription: 'Backup to another phone',
            icon: Icons.qr_code,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class PresentPage extends StatelessWidget {
  final int identityIndex;
  final int claimIndex;

  const PresentPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  Widget build(BuildContext context) {
    var state2 = context.watch<PolycentricModel>();
    var identity2 = state2.identities[identityIndex];
    var claim2 = identity2.claims[claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity2.avatar != null ? identity2.avatar!.image : null,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                identity2.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
          Text(
            "Requests you to verify their claim",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Freeform",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            claim2.text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: QrImage(
              backgroundColor: Colors.white,
              data: base64.encode(claim2.pointer.writeToBuffer()),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Scan to Verify",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          StandardButton(
            actionText: 'Copy',
            actionDescription: 'Share this unique code with others to verify',
            icon: Icons.content_copy,
            onPressed: () async {},
          ),
          StandardButton(
            actionText: 'Share',
            actionDescription: 'Share code for verification',
            icon: Icons.share,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
