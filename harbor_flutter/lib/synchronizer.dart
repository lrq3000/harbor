import 'package:flutter/foundation.dart' as foundation;
import 'package:sqflite/sqflite.dart' as sqflite;

import 'main.dart' as main;
import 'protocol.pb.dart' as protocol;
import 'api_methods.dart' as api_methods;
import 'ranges.dart' as ranges;
import 'queries.dart' as queries;
import 'logger.dart';

bool processDeepEqual(final protocol.Process x, final protocol.Process y) {
  return foundation.listEquals(x.process, y.process);
}

List<ranges.Range> protocolRangesToRanges(final List<protocol.Range> x) {
  return x.map((item) => ranges.Range(low: item.low, high: item.high)).toList();
}

List<protocol.Range> rangesToProtocolRanges(final List<ranges.Range> x) {
  return x.map((item) {
    final range = protocol.Range();
    range.low = item.low;
    range.high = item.high;
    return range;
  }).toList();
}

Future<bool> backfillClientSingle(
  final sqflite.Database db,
  final protocol.PublicKey system,
  final String server,
) async {
  logger.d('backfillClientSingle $server');

  final serverRangesForSystem = await api_methods.getRanges(server, system);
  final clientRangesForSystem = await db.transaction((transaction) async {
    return await queries.rangesForSystem(transaction, system);
  });

  var progress = false;

  for (final serverRangesForProcess
      in serverRangesForSystem.rangesForProcesses) {
    var serverRanges = protocolRangesToRanges(serverRangesForProcess.ranges);
    List<ranges.Range> clientRanges = [];

    for (final clientRangesForProcess
        in clientRangesForSystem.rangesForProcesses) {
      if (processDeepEqual(
        clientRangesForProcess.process,
        serverRangesForProcess.process,
      )) {
        clientRanges = protocolRangesToRanges(clientRangesForProcess.ranges);
        break;
      }
    }

    final clientNeeds = ranges.subtractRange(serverRanges, clientRanges);

    if (clientNeeds.isEmpty) {
      break;
    }

    final rangesForProcess = protocol.RangesForProcess()
      ..process = serverRangesForProcess.process
      ..ranges.addAll(rangesToProtocolRanges(clientNeeds));

    final request = protocol.RangesForSystem()
      ..rangesForProcesses.add(rangesForProcess);

    final events = await api_methods.getEvents(server, system, request);

    if (events.events.isEmpty) {
      continue;
    }

    progress = true;

    for (final event in events.events) {
      await db.transaction((transaction) async {
        await main.ingest(transaction, event);
      });
    }
  }

  return progress;
}

Future<bool> backfillClient(
  final sqflite.Database db,
  final protocol.PublicKey system,
) async {
  final servers = await db.transaction((transaction) async {
    return await main.loadServerList(transaction, system.key);
  });

  var progress = false;

  for (final server in servers) {
    final subProgress = await backfillClientSingle(db, system, server);

    if (subProgress == true) {
      progress = true;
    }
  }

  logger.d('backfillclient progress $progress');

  return progress;
}

Future<bool> backfillServerSingle(
  final sqflite.Database db,
  final protocol.PublicKey system,
  final String server,
) async {
  logger.d('backfillServerSingle $server');

  final serverRangesForSystem = await api_methods.getRanges(server, system);
  final clientRangesForSystem = await db.transaction((transaction) async {
    return await queries.rangesForSystem(transaction, system);
  });

  var progress = false;

  for (final clientRangesForProcess
      in clientRangesForSystem.rangesForProcesses) {
    var clientRanges = protocolRangesToRanges(clientRangesForProcess.ranges);
    List<ranges.Range> serverRanges = [];

    for (final serverRangesForProcess
        in serverRangesForSystem.rangesForProcesses) {
      if (processDeepEqual(
        clientRangesForProcess.process,
        serverRangesForProcess.process,
      )) {
        serverRanges = protocolRangesToRanges(serverRangesForProcess.ranges);
        break;
      }
    }

    final serverNeeds = ranges.subtractRange(clientRanges, serverRanges);

    if (serverNeeds.isEmpty) {
      continue;
    }

    final protocol.Events payload = protocol.Events();

    await db.transaction((transaction) async {
      for (final range in serverNeeds) {
        logger.d('loading range $range');
        payload.events.addAll(
          await queries.loadEventRange(
            transaction,
            system.key,
            clientRangesForProcess.process.process,
            range,
          ),
        );
      }
    });

    logger.d('sending count ${payload.events.length}');

    await api_methods.postEvents(server, payload);

    progress = true;
  }

  return progress;
}

Future<bool> backfillServers(
  final sqflite.Database db,
  final protocol.PublicKey system,
) async {
  final servers = await db.transaction((transaction) async {
    return await main.loadServerList(transaction, system.key);
  });

  var progress = false;

  for (final server in servers) {
    final subProgress = await backfillServerSingle(db, system, server);

    if (subProgress == true) {
      progress = true;
    }
  }

  logger.d('backfillServers progress $progress');

  return progress;
}
