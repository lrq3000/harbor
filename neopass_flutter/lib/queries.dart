import 'dart:typed_data';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:path/path.dart' as path;

import 'protocol.pb.dart' as protocol;

const schemaTableEvents = '''
CREATE TABLE IF NOT EXISTS events (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    process         BLOB    NOT NULL,
    logical_clock   INTEGER NOT NULL,
    content_type    INTEGER NOT NULL,
    raw_event       BLOB    NOT NULL,

    UNIQUE(system_key_type, system_key, process, logical_clock)
);
''';

const schemaTableProcessSecrets = '''
CREATE TABLE IF NOT EXISTS process_secrets (
    id              INTEGER PRIMARY KEY,
    system_key_type INTEGER NOT NULL,
    system_key      BLOB    NOT NULL,
    system_key_pub  BLOB    NOT NULL,
    process         BLOB    NOT NULL,

    UNIQUE(system_key_type, system_key, process)
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

const schemaTableCRDTSetItems = '''
CREATE TABLE IF NOT EXISTS crdt_set_items (
    id                INTEGER PRIMARY KEY,
    unix_milliseconds INTEGER NOT NULL,
    operation         BOOLEAN NOT NULL,
    value             BLOB    NOT NULL,
    event_id          INTEGER NOT NULL,

    FOREIGN KEY (event_id)
      REFERENCES events (id)
      ON DELETE CASCADE
);
''';

Future<sqflite.Database> createDB(String name) async {
  return await sqflite.openDatabase(
    path.join(await sqflite.getDatabasesPath(), name),
    onCreate: (db, version) async {
      await db.execute(schemaTableEvents);
      await db.execute(schemaTableProcessSecrets);
      await db.execute(schemaTableDeletions);
      await db.execute(schemaTableCRDTs);
      await db.execute(schemaTableCRDTSetItems);
    },
    version: 1,
  );
}

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

Future<bool> doesEventExist(
  sqflite.Transaction transaction,
  protocol.Event event,
) async {
  const query = '''
      SELECT 1 FROM events
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

Future<void> insertCRDTSetItem(
  sqflite.Transaction transaction,
  int rowId,
  protocol.LWWElementSet element,
) async {
  const query = '''
    INSERT INTO crdt_set_items
    (
      unix_milliseconds,
      operation,
      value,
      event_id
    )
    VALUES (?, ?, ?, ?);
  ''';

  await transaction.rawQuery(query, [
    element.unixMilliseconds.toInt(),
    element.operation.value,
    Uint8List.fromList(element.value),
    rowId,
  ]);
}

Future<int> insertEvent(
  sqflite.Transaction transaction,
  protocol.SignedEvent signedEvent,
  protocol.Event event,
) async {
  return await transaction.rawInsert('''
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
}

Future<void> deleteIdentity(
  sqflite.Transaction transaction,
  List<int> system,
  List<int> process,
) async {
  const query = '''
      DELETE FROM process_secrets
      WHERE system_key_type = 1
      AND system_key_pub = ?
      AND process = ?;
  ''';

  await transaction.rawDelete(
      query, [Uint8List.fromList(system), Uint8List.fromList(process)]);
}

Future<protocol.SignedEvent?> loadEvent(
  sqflite.Transaction transaction,
  List<int> system,
  List<int> process,
  fixnum.Int64 logicalClock,
) async {
  final rows = await transaction.rawQuery('''
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

Future<void> insertProcessSecret(
  sqflite.Transaction transaction,
  Uint8List publicKey,
  Uint8List privateKey,
  int keyType,
  Uint8List process,
) async {
  await transaction.rawInsert('''
            INSERT INTO process_secrets (
                system_key_type,
                system_key,
                system_key_pub,
                process
            ) VALUES(?, ?, ?, ?);
        ''', [
    keyType,
    privateKey,
    publicKey,
    process,
  ]);
}

Future<int> loadLatestClock(
  sqflite.Transaction transaction,
  List<int> system,
  List<int> process,
) async {
  final f = sqflite.Sqflite.firstIntValue(await transaction.rawQuery('''
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

Future<protocol.SignedEvent?> loadLatestEventByContentType(
  sqflite.Transaction transaction,
  List<int> system,
  List<int> process,
  fixnum.Int64 contentType,
) async {
  final q = await transaction.rawQuery('''
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
  sqflite.Transaction transaction,
  List<int> system,
  fixnum.Int64 contentType,
) async {
  final q = await transaction.rawQuery('''
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

Future<List<protocol.SignedEvent>> loadEventsForSystemByContentType(
  sqflite.Transaction transaction,
  List<int> system,
  fixnum.Int64 contentType,
) async {
  final rows = await transaction.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND content_type = ?;
    ''', [Uint8List.fromList(system), contentType.toInt()]);

  final List<protocol.SignedEvent> result = [];

  for (final row in rows) {
    result.add(protocol.SignedEvent.fromBuffer(row['raw_event'] as List<int>));
  }

  return result;
}

Future<List<protocol.SignedEvent>> loadLatestCRDTSetItemsByContentType(
  sqflite.Transaction transaction,
  List<int> system,
  fixnum.Int64 contentType,
) async {
  final rows = await transaction.rawQuery('''
    WITH latest_values AS (
        SELECT
          events.raw_event as raw_event,
          crdt_set_items.value as value,
          MAX(crdt.set_items.unix_milliseconds),
        FROM
          crdt_set_items
        JOIN
          events
        ON
          crdt_set_items.event_id = events.id
        WHERE
          events.content_type = ?
        AND
          events.system_key_type = 1
        AND
          events.system_key = ?
        GROUP BY
            crdt_set_items.value
    )
    SELECT
        raw_event
    FROM
        latest_values
    WHERE
        latest_values.value = 0
    ''', [contentType.toInt(), Uint8List.fromList(system)]);

  final List<protocol.SignedEvent> result = [];

  for (final row in rows) {
    result.add(protocol.SignedEvent.fromBuffer(row['raw_event'] as List<int>));
  }

  return result;
}
