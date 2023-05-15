import 'dart:typed_data';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:fixnum/fixnum.dart' as fixnum;

import 'protocol.pb.dart' as protocol;

Future<protocol.RangesForSystem> rangesForSystem(
  sqflite.Transaction transaction,
  protocol.PublicKey system,
) async {
  const query = '''
      SELECT
          process,
          MIN(logical_clock) as low,
          MAX(logical_clock) as high
      FROM (
          SELECT
              *, ROW_NUMBER() OVER(ORDER BY process, logical_clock) as rn
          FROM (
              SELECT
                  process, logical_clock
              FROM
                  events
              WHERE
                  system_key_type = \$1
              AND
                  system_key = \$2
              UNION ALL
              SELECT
                  process, logical_clock
              FROM
                  deletions
              WHERE
                  system_key_type = \$1
              AND
                  system_key = \$2
          ) t2
      ) t1
      GROUP BY process, logical_clock - rn;
  ''';

  final List<Map> rows = await transaction.rawQuery(query, [
    system.keyType.toInt(),
    Uint8List.fromList(system.key),
  ]);

  protocol.RangesForSystem? result = protocol.RangesForSystem();

  for (final row in rows) {
    final process = protocol.Process();
    process.process = row['process'] as List<int>;

    protocol.RangesForProcess? found;

    for (final rangesForProcess in result.rangesForProcesses) {
      if (rangesForProcess.process == process) {
        found = rangesForProcess;
        break;
      }
    }

    if (found == null) {
      found = protocol.RangesForProcess();
      found.process = process;
      result.rangesForProcesses.add(found);
    }

    final range = protocol.Range();
    range.low = fixnum.Int64(row['low'] as int);
    range.high = fixnum.Int64(row['high'] as int);

    found.ranges.add(range);
  }

  return result;
}
