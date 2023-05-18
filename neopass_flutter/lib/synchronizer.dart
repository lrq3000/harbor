import 'package:flutter/foundation.dart' as foundation;
import 'package:sqflite/sqflite.dart' as sqflite;

import 'main.dart' as main;
import 'protocol.pb.dart' as protocol;
import 'api_methods.dart' as api_methods;
import 'ranges.dart' as ranges;
import 'queries.dart' as queries;
import 'logger.dart';

bool processDeepEqual(protocol.Process x, protocol.Process y) {
  return foundation.listEquals(x.process, y.process);
}

List<ranges.Range> protocolRangesToRanges(List<protocol.Range> x) {
  return x.map((item) => ranges.Range(low: item.low, high: item.high)).toList();
}

List<protocol.Range> rangesToProtocolRanges(List<ranges.Range> x) {
  return x.map((item) {
    final range = protocol.Range();
    range.low = item.low;
    range.high = item.high;
    return range;
  }).toList();
}

Future<bool> backfillClientSingle(
  sqflite.Database db,
  protocol.PublicKey system,
  String server,
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

    final request = protocol.RangesForSystem(rangesForProcesses: [
      protocol.RangesForProcess(
        process: serverRangesForProcess.process,
        ranges: rangesToProtocolRanges(clientNeeds),
      ),
    ]);

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
  sqflite.Database db,
  protocol.PublicKey system,
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

  return progress;
}
