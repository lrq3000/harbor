import 'dart:typed_data';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:path/path.dart' as path;

import 'protocol.pb.dart' as protocol;
import 'ranges.dart' as ranges;

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

    UNIQUE(system_key_type, system_key)
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

Future<sqflite.Database> createDB(final String name) async {
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
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

Future<bool> doesProcessSecretExistForSystem(
  final sqflite.Transaction transaction,
  final protocol.KeyPair system,
) async {
  const query = '''
        SELECT 1 FROM process_secrets
        WHERE system_key_type = ?
        AND system_key = ?
        LIMIT 1;
    ''';

  final rows = await transaction.rawQuery(query, [
    system.keyType.toInt(),
    Uint8List.fromList(system.privateKey),
  ]);

  return rows.isNotEmpty;
}

Future<bool> isEventDeleted(
  final sqflite.Transaction transaction,
  final protocol.Event event,
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
  final sqflite.Transaction transaction,
  final protocol.Event event,
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
  final sqflite.Transaction transaction,
  final int rowId,
  final protocol.PublicKey system,
  final protocol.Delete deleteBody,
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
  final sqflite.Transaction transaction,
  final int rowId,
  final protocol.LWWElement element,
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
  final sqflite.Transaction transaction,
  final int rowId,
  final protocol.LWWElementSet element,
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
  final sqflite.Transaction transaction,
  final protocol.SignedEvent signedEvent,
  final protocol.Event event,
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final List<int> process,
) async {
  const query = '''
      DELETE FROM process_secrets
      WHERE system_key_type = 1
      AND system_key_pub = ?
      AND process = ?;
  ''';

  await transaction.rawDelete(
      query, [Uint8List.fromList(system.key), Uint8List.fromList(process)]);
}

Future<protocol.SignedEvent?> loadEvent(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final List<int> process,
  final fixnum.Int64 logicalClock,
) async {
  final rows = await transaction.rawQuery('''
    SELECT raw_event FROM events
    WHERE system_key_type = 1
    AND system_key = ?
    AND process = ?
    AND logical_clock = ?
    LIMIT 1;
  ''', [
    Uint8List.fromList(system.key),
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
  final sqflite.Transaction transaction,
  final Uint8List publicKey,
  final Uint8List privateKey,
  final int keyType,
  final Uint8List process,
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final List<int> process,
) async {
  final f = sqflite.Sqflite.firstIntValue(await transaction.rawQuery('''
        SELECT MAX(logical_clock) as x FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND process = ?;
    ''', [Uint8List.fromList(system.key), Uint8List.fromList(process)]));

  if (f == null) {
    return 0;
  } else {
    return f + 1;
  }
}

Future<protocol.SignedEvent?> loadLatestEventByContentType(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final List<int> process,
  final fixnum.Int64 contentType,
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
    Uint8List.fromList(system.key),
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
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final fixnum.Int64 contentType,
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
    ''', [contentType.toInt(), Uint8List.fromList(system.key)]);

  if (q.isEmpty) {
    return null;
  } else {
    return protocol.SignedEvent.fromBuffer(q[0]['raw_event'] as List<int>);
  }
}

Future<List<protocol.SignedEvent>> loadEventsForSystemByContentType(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final fixnum.Int64 contentType,
) async {
  final rows = await transaction.rawQuery('''
        SELECT raw_event FROM events
        WHERE system_key_type = 1
        AND system_key = ?
        AND content_type = ?;
    ''', [Uint8List.fromList(system.key), contentType.toInt()]);

  final List<protocol.SignedEvent> result = [];

  for (final row in rows) {
    result.add(protocol.SignedEvent.fromBuffer(row['raw_event'] as List<int>));
  }

  return result;
}

Future<List<protocol.SignedEvent>> loadLatestCRDTSetItemsByContentType(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final fixnum.Int64 contentType,
) async {
  final rows = await transaction.rawQuery('''
    WITH latest_values AS (
        SELECT
          events.raw_event as raw_event,
          crdt_set_items.operation as operation,
          MAX(crdt_set_items.unix_milliseconds)
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
        latest_values.operation = 0
    ''', [contentType.toInt(), Uint8List.fromList(system.key)]);

  final List<protocol.SignedEvent> result = [];

  for (final row in rows) {
    result.add(protocol.SignedEvent.fromBuffer(row['raw_event'] as List<int>));
  }

  return result;
}

Future<List<protocol.SignedEvent>> loadEventRange(
  final sqflite.Transaction transaction,
  final protocol.PublicKey system,
  final List<int> process,
  final ranges.Range range,
) async {
  final rows = await transaction.rawQuery('''
    SELECT raw_event FROM events
    WHERE system_key_type = 1
    AND system_key = ?
    AND process = ?
    AND logical_clock >= ?
    AND logical_clock <= ?
  ''', [
    Uint8List.fromList(system.key),
    Uint8List.fromList(process),
    range.low.toInt(),
    range.high.toInt(),
  ]);

  final List<protocol.SignedEvent> result = [];

  for (final row in rows) {
    result.add(protocol.SignedEvent.fromBuffer(row['raw_event'] as List<int>));
  }

  return result;
}
