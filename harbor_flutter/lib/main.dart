import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'dart:collection';
import 'package:fixnum/fixnum.dart' as fixnum;

import 'api_methods.dart' as api_methods;
import 'pages/new_or_import_profile.dart';
import 'models.dart' as models;
import 'protocol.pb.dart' as protocol;
import 'protocol.pb.dart';
import 'synchronizer.dart' as synchronizer;
import 'queries.dart' as queries;
import 'shared_ui.dart' as shared_ui;
import 'ranges.dart' as ranges;
import 'logger.dart';

final UnmodifiableSetView<fixnum.Int64> oAuthClaimTypes = UnmodifiableSetView({
  models.ClaimType.claimTypeDiscord,
  models.ClaimType.claimTypeInstagram,
  models.ClaimType.claimTypeTwitter,
});

class ProcessSecret {
  cryptography.SimpleKeyPair system;
  List<int> process;

  ProcessSecret(this.system, this.process);
}

bool isOAuthClaim(final fixnum.Int64 claimType) {
  return oAuthClaimTypes.contains(claimType);
}

Future<ProcessSecret> createNewIdentity(final sqflite.Database db) async {
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
  final sqflite.Transaction transaction,
  final cryptography.SimpleKeyPair keyPair,
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

  final publicProto = protocol.PublicKey()
    ..keyType = fixnum.Int64(1)
    ..key = public.bytes;

  logger.i("imported: ${base64Url.encode(publicProto.writeToBuffer())}");

  return ProcessSecret(keyPair, process);
}

Future<List<ProcessSecret>> loadIdentities(final sqflite.Database db) async {
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

Future<String> makeSystemLink(
  final sqflite.Database db,
  final protocol.PublicKey system,
) async {
  final servers = await db.transaction((transaction) async {
    return await loadServerList(transaction, system);
  });

  final systemLink = protocol.URLInfoSystemLink()
    ..system = system
    ..servers.addAll(servers);

  final urlInfo = protocol.URLInfo()
    ..urlType = models.URLInfoType.urlInfoTypeSystemLink
    ..body = systemLink.writeToBuffer();

  return models.urlInfoToLinkSuffix(urlInfo);
}

Future<String> makeEventLink(
  final sqflite.Database db,
  final protocol.PublicKey system,
  final protocol.Process process,
  final fixnum.Int64 logicalClock,
) async {
  final servers = await db.transaction((transaction) async {
    return await loadServerList(transaction, system);
  });

  final eventLink = protocol.URLInfoEventLink()
    ..system = system
    ..process = process
    ..logicalClock = logicalClock
    ..servers.addAll(servers);

  final urlInfo = protocol.URLInfo()
    ..urlType = models.URLInfoType.urlInfoTypeEventLink
    ..body = eventLink.writeToBuffer();

  return models.urlInfoToLink(urlInfo);
}

Future<String> makeExportBundle(
  final sqflite.Database db,
  final ProcessSecret processSecret,
) async {
  final privateKey = await processSecret.system.extractPrivateKeyBytes();
  final publicKey = (await processSecret.system.extractPublicKey()).bytes;

  final system = protocol.PublicKey()
    ..keyType = fixnum.Int64(1)
    ..key = publicKey;

  final events = protocol.Events();

  await db.transaction((transaction) async {
    final usernameSignedEvent = await queries.loadLatestCRDTByContentType(
      transaction,
      system,
      models.ContentType.contentTypeUsername,
    );

    if (usernameSignedEvent != null) {
      events.events.add(usernameSignedEvent);
    }

    final serverSignedEvents =
        await queries.loadLatestCRDTSetItemsByContentType(
      transaction,
      system,
      models.ContentType.contentTypeServer,
    );

    events.events.addAll(serverSignedEvents);
  });

  final keyPair = protocol.KeyPair()
    ..keyType = fixnum.Int64(1)
    ..privateKey = privateKey
    ..publicKey = publicKey;

  final exportBundle = protocol.ExportBundle()
    ..keyPair = keyPair
    ..events = events;

  final urlInfo = protocol.URLInfo()
    ..urlType = models.URLInfoType.urlInfoTypeExportBundle
    ..body = exportBundle.writeToBuffer();

  return models.urlInfoToLink(urlInfo);
}

// returns false if identity already exists
// returns true on success
// throws on other error
Future<bool> importExportBundle(
  final sqflite.Database db,
  final protocol.ExportBundle exportBundle,
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

  return await db.transaction((transaction) async {
    final exists = await queries.doesProcessSecretExistForSystem(
      transaction,
      exportBundle.keyPair,
    );

    if (exists == true) {
      return false;
    }

    await importIdentity(transaction, keyPair);

    for (final event in exportBundle.events.events) {
      await ingest(transaction, event);
    }

    return true;
  });
}

Future<protocol.Event?> getEventWhenValid(
    final protocol.SignedEvent signedEvent) async {
  final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

  final publicKey = cryptography.SimplePublicKey(
    event.system.key,
    type: cryptography.KeyPairType.ed25519,
  );

  final signature = cryptography.Signature(
    signedEvent.signature,
    publicKey: publicKey,
  );

  final validSignature = await cryptography.Ed25519().verify(
    signedEvent.event,
    signature: signature,
  );

  return validSignature ? event : null;
}

Future<protocol.Event> getEventWhenValidCompute(
    final protocol.SignedEvent signedEvent) async {
  final event = await compute(getEventWhenValid, signedEvent);

  if (event == null) {
    throw Exception('Invalid signature');
  }

  return event;
}

class _GetVouchersComputeArgs {
  final List<String> servers;
  final Pointer claimPointer;

  _GetVouchersComputeArgs(this.servers, this.claimPointer);
}

Future<List<PublicKey>> _getVouchersCompute(
    final _GetVouchersComputeArgs args) async {
  final List<String> servers = args.servers;
  final Pointer claimPointer = args.claimPointer;

  final reference = Reference()
    ..reference = claimPointer.writeToBuffer()
    ..referenceType = Int64(2);

  final queryReferencesRequestEvents = QueryReferencesRequestEvents()
    ..fromType = models.ContentType.contentTypeVouch;

  final futures = <Future<QueryReferencesResponse>>[];
  for (final server in servers) {
    futures.add(api_methods.getQueryReferences(
        server, reference, null, queryReferencesRequestEvents, null, null));
  }

  final List<SignedEvent> vouchEvents = List.empty(growable: true);
  final responses = await Future.wait(futures);
  for (var response in responses) {
    vouchEvents.addAll(response.items.map((e) => e.event));
    //TODO: Can we deduplicate the list early?
    //TODO: Handle more than X vouchers by using cursor to get the next page
  }

  final vouchers = <PublicKey>[];
  for (final se in vouchEvents) {
    final e = await getEventWhenValid(se);
    if (e == null) {
      continue;
    }

    final referenceMatches = e.references
        .any((r) => claimPointer == Pointer.fromBuffer(r.reference));
    if (referenceMatches) {
      if (!vouchers.contains(e.system)) {
        vouchers.add(e.system);
      }
    }
  }

  return vouchers;
}

Future<List<PublicKey>> getVouchersAsync(
    final List<String> servers, final Pointer claimPointer) async {
  _GetVouchersComputeArgs args = _GetVouchersComputeArgs(servers, claimPointer);
  return compute(_getVouchersCompute, args);
}

class _GetProfileComputeArgs {
  final List<String> servers;
  final PublicKey system;

  _GetProfileComputeArgs(this.servers, this.system);
}

Future<models.SystemState> _getProfileCompute(
    final _GetProfileComputeArgs args) async {
  final futures = <Future<Events>>[];
  for (final server in args.servers) {
    futures.add(api_methods.getQueryLatest(
        server,
        args.system,
        UnmodifiableListView([
          models.ContentType.contentTypeUsername,
          models.ContentType.contentTypeAvatar
        ])));
  }

  final storageTypeSystemState = models.StorageTypeSystemState();
  final responses = await Future.wait(futures);
  for (final response in responses) {
    for (final se in response.events) {
      final e = await getEventWhenValid(se);
      if (e == null) {
        continue;
      }

      storageTypeSystemState.update(e);
    }
  }

  return models.SystemState.fromStorageTypeSystemState(storageTypeSystemState);
}

Future<models.SystemState> getProfileAsync(
    final List<String> servers, final PublicKey system) async {
  _GetProfileComputeArgs args = _GetProfileComputeArgs(servers, system);
  return compute(_getProfileCompute, args);
}

Future<void> ingest(
  final sqflite.Transaction transaction,
  final protocol.SignedEvent signedEvent,
) async {
  final event = await getEventWhenValidCompute(signedEvent);

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
    final protocol.SignedEvent signedEvent) async {
  final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

  final hash = await cryptography.Sha256().hash(signedEvent.event);

  final digest = protocol.Digest()
    ..digestType = fixnum.Int64(1)
    ..digest = hash.bytes;

  return protocol.Pointer()
    ..system = event.system
    ..process = event.process
    ..logicalClock = event.logicalClock
    ..eventDigest = digest;
}

Future<List<ClaimInfo>> loadClaims(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
) async {
  final signedEvents = await queries.loadEventsForSystemByContentType(
    transaction,
    system,
    models.ContentType.contentTypeClaim,
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
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

Future<String> loadLatestStore(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
) async {
  final signedEvent = await queries.loadLatestCRDTByContentType(
    transaction,
    system,
    models.ContentType.contentTypeStore,
  );

  if (signedEvent == null) {
    return '';
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    return utf8.decode(event.lwwElement.value);
  }
}

Future<Image?> loadImage(
  final sqflite.Transaction transaction,
  final String mime,
  final protocol.PublicKey system,
  final protocol.Process process,
  final List<protocol.Range> sections,
) async {
  final List<int> buffer = [];

  for (final section in sections) {
    for (var i = section.low; i <= section.high; i++) {
      final signedEvent = await queries.loadEvent(
        transaction,
        system,
        process.process,
        i,
      );

      if (signedEvent == null) {
        return null;
      }

      final event = protocol.Event.fromBuffer(signedEvent.event);

      if (event.contentType != models.ContentType.contentTypeBlobSection) {
        logger.d("expected blob section event but got: "
            "${event.contentType.toString()}");

        return null;
      }

      buffer.addAll(event.content);
    }
  }

  return Image.memory(Uint8List.fromList(buffer));
}

Future<Image?> loadLatestAvatar(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
) async {
  try {
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

      final protocol.ImageBundle bundle = protocol.ImageBundle.fromBuffer(
        event.lwwElement.value,
      );

      final protocol.ImageManifest manifest = bundle.imageManifests.firstWhere(
          (manifest) =>
              manifest.width == fixnum.Int64(256) &&
              manifest.height == fixnum.Int64(256));

      return loadImage(transaction, manifest.mime, system, manifest.process,
          manifest.sections);
    }
  } catch (err) {
    return null;
  }
}

Future<protocol.Pointer> saveEvent(final sqflite.Transaction transaction,
    final ProcessSecret processInfo, final protocol.Event event) async {
  final public = await processInfo.system.extractPublicKey();

  final protocol.PublicKey system = protocol.PublicKey()
    ..keyType = fixnum.Int64(1)
    ..key = public.bytes;

  final protocol.Process process = protocol.Process()
    ..process = processInfo.process;

  final clock = await queries.loadLatestClock(
    transaction,
    system,
    processInfo.process,
  );

  event.system = system;
  event.process = process;
  event.logicalClock = fixnum.Int64(clock);
  event.vectorClock = protocol.VectorClock();
  event.indices = protocol.Indices();
  event.unixMilliseconds = fixnum.Int64(DateTime.now().millisecondsSinceEpoch);

  final encoded = event.writeToBuffer();
  final signature = (await cryptography.Ed25519().sign(
    encoded,
    keyPair: processInfo.system,
  ))
      .bytes;

  final protocol.SignedEvent signedEvent = protocol.SignedEvent()
    ..event = encoded
    ..signature = signature;

  await ingest(transaction, signedEvent);

  return await signedEventToPointer(signedEvent);
}

Future<void> deleteEvent(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final protocol.Pointer pointer,
) async {
  final signedEvent = await queries.loadEvent(
    transaction,
    pointer.system,
    pointer.process.process,
    pointer.logicalClock,
  );

  if (signedEvent == null) {
    logger.d("cannot delete event that does not exist");
    return;
  } else {
    final protocol.Event event = protocol.Event.fromBuffer(signedEvent.event);

    final delete = protocol.Delete()
      ..process = pointer.process
      ..logicalClock = pointer.logicalClock
      ..indices = event.indices
      ..unixMilliseconds = event.unixMilliseconds
      ..contentType = event.contentType;

    final protocol.Event deleteEvent = protocol.Event()
      ..contentType = models.ContentType.contentTypeDelete
      ..content = delete.writeToBuffer();

    await saveEvent(transaction, processInfo, deleteEvent);
  }
}

Future<List<ranges.Range>> publishBlob(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String mime,
  final List<int> bytes,
) async {
  final List<ranges.Range> result = [];

  const maxBytes = 1024 * 512;

  for (var i = 0; i < bytes.length; i += maxBytes) {
    final sectionEvent = protocol.Event()
      ..contentType = models.ContentType.contentTypeBlobSection
      ..content = bytes.sublist(i, min(i + maxBytes, bytes.length - i));

    final pointer = await saveEvent(transaction, processInfo, sectionEvent);

    ranges.insert(result, pointer.logicalClock);
  }

  return result;
}

Future<void> setCRDT(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final fixnum.Int64 contentType,
  final Uint8List bytes,
) async {
  final lwwElement = protocol.LWWElement()
    ..unixMilliseconds = fixnum.Int64(DateTime.now().millisecondsSinceEpoch)
    ..value = bytes;

  final protocol.Event event = protocol.Event()
    ..contentType = contentType
    ..lwwElement = lwwElement;

  await saveEvent(transaction, processInfo, event);
}

Future<void> setAvatar(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final protocol.ImageBundle imageBundle,
) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeAvatar,
    imageBundle.writeToBuffer(),
  );
}

Future<void> setUsername(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String username,
) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeUsername,
    Uint8List.fromList(utf8.encode(username)),
  );
}

Future<void> setDescription(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String description,
) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeDescription,
    Uint8List.fromList(utf8.encode(description)),
  );
}

Future<void> setStore(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String storeLink,
) async {
  await setCRDT(
    transaction,
    processInfo,
    models.ContentType.contentTypeStore,
    Uint8List.fromList(utf8.encode(storeLink)),
  );
}

Future<void> makeClaim(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String claimText,
) async {
  final claim = models.claimIdentifier(
    models.ClaimType.claimTypeGeneric,
    claimText,
  );

  final protocol.Event event = protocol.Event()
    ..contentType = models.ContentType.contentTypeClaim
    ..content = claim.writeToBuffer();

  await saveEvent(transaction, processInfo, event);
}

Future<void> setCRDTSetItem(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final fixnum.Int64 contentType,
  final protocol.LWWElementSet_Operation operation,
  final Uint8List value,
) async {
  final lwwElementSet = protocol.LWWElementSet()
    ..unixMilliseconds = fixnum.Int64(DateTime.now().millisecondsSinceEpoch)
    ..value = value
    ..operation = operation;

  final protocol.Event event = protocol.Event()
    ..contentType = contentType
    ..lwwElementSet = lwwElementSet;

  await saveEvent(transaction, processInfo, event);
}

Future<void> setServer(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final protocol.LWWElementSet_Operation operation,
  final String server,
) async {
  await setCRDTSetItem(
    transaction,
    processInfo,
    models.ContentType.contentTypeServer,
    operation,
    Uint8List.fromList(utf8.encode(server)),
  );
}

Future<ClaimInfo> persistClaim(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final protocol.Claim claim,
) async {
  final protocol.Event event = protocol.Event()
    ..contentType = models.ContentType.contentTypeClaim
    ..content = claim.writeToBuffer();

  final pointer = await saveEvent(transaction, processInfo, event);

  return ClaimInfo(pointer, event);
}

Future<ClaimInfo> makePlatformClaim(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final fixnum.Int64 claimType,
  final String account,
) async {
  return await persistClaim(
    transaction,
    processInfo,
    models.claimIdentifier(claimType, account),
  );
}

Future<ClaimInfo> makeOccupationClaim(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final String organization,
  final String role,
  final String location,
) async {
  return await persistClaim(
    transaction,
    processInfo,
    models.claimOccupation(organization, role, location),
  );
}

Future<void> makeVouch(
  final sqflite.Transaction transaction,
  final ProcessSecret processInfo,
  final protocol.Pointer pointer,
) async {
  final reference = protocol.Reference()
    ..referenceType = fixnum.Int64(2)
    ..reference = pointer.writeToBuffer();

  final protocol.Event event = protocol.Event()
    ..contentType = models.ContentType.contentTypeVouch
    ..references.add(reference);

  await saveEvent(transaction, processInfo, event);
}

Future<void> main() async {
  FlutterCryptography.enable();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light); // light color time text

  final provider = await setupModel();
  await provider.mLoadIdentities();

  runApp(NeopassApp(polycentricModel: provider));
}

class ClaimInfo {
  final protocol.Pointer pointer;
  final protocol.Event event;
  protocol.Claim claim = protocol.Claim();

  ClaimInfo(this.pointer, this.event) {
    claim = protocol.Claim.fromBuffer(event.content);
  }

  String? getField(final fixnum.Int64 key) {
    for (final field in claim.claimFields) {
      if (field.key == key) {
        return field.value;
      }
    }

    return null;
  }
}

class ProcessInfo {
  final ProcessSecret processSecret;
  final protocol.PublicKey system;
  final String username;
  final List<ClaimInfo> claims;
  final Image? avatar;
  final String description;
  final String store;
  final List<String> servers;

  ProcessInfo(this.processSecret, this.system, this.username, this.claims,
      this.avatar, this.description, this.store, this.servers);
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

      final system = protocol.PublicKey()
        ..keyType = fixnum.Int64(1)
        ..key = public.bytes;

      await db.transaction((transaction) async {
        final username = await loadLatestUsername(
          transaction,
          system,
        );

        final description = await loadLatestDescription(
          transaction,
          system,
        );

        final store = await loadLatestStore(
          transaction,
          system,
        );

        final avatar = await loadLatestAvatar(
          transaction,
          system,
        );

        final servers = await loadServerList(transaction, system);
        final claims = await loadClaims(transaction, system);

        this.identities.add(
              ProcessInfo(identity, system, username, claims, avatar,
                  description, store, servers),
            );
      });

      synchronizer.backfillClient(db, system);
      synchronizer.backfillServers(db, system);
    }

    notifyListeners();
  }
}

Future<PolycentricModel> setupModel() async {
  return PolycentricModel(await queries.createDB('neopass17.db'));
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
          dialogBackgroundColor: shared_ui.buttonColor,
          fontFamily: 'inter',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        home: SafeArea(child: initialPage),
      ),
    );
  }
}
