import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/typedefs/progress_callback.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/collect_report_events.dart';
import 'package:pay_pilot/core/database/tables/event_orders.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/guests.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/menus.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/features/settings/data/models/backup_report.dart';

part 'settings_dao.g.dart';

@DriftAccessor(
  tables: [
    Events,
    Teams,
    EventTransactions,
    EventRatios,
    Ratios,
    EventOrders,
    CollectReportEvents,
    Guests,
    Members,
    Menus,
    Reports,
  ],
)
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  // Future<Map<String, dynamic>> getAllData() async {
  //   final collectReportEvents = await db.select(db.collectReportEvents).get();
  //   final eventOrders = await db.select(db.eventOrders).get();
  //   final eventRatios = await db.select(db.eventRatios).get();
  //   final eventTransactions = await db.select(db.eventTransactions).get();
  //   final events = await db.select(db.events).get();
  //   final guests = await db.select(db.guests).get();
  //   final members = await db.select(db.members).get();
  //   final menus = await db.select(db.menus).get();
  //   final ratios = await db.select(db.ratios).get();
  //   final reports = await db.select(db.reports).get();
  //   final teams = await db.select(db.teams).get();

  //   final dbData = <String, dynamic>{
  //     'collectReportEvents': collectReportEvents,
  //     'eventOrders': eventOrders,
  //     'eventRatios': eventRatios,
  //     'eventTransactions': eventTransactions,
  //     'events': events,
  //     'guests': guests,
  //     'members': members,
  //     'menus': menus,
  //     'ratios': ratios,
  //     'reports': reports,
  //     'teams': teams,
  //   };

  //   return dbData;
  // }

  // Future<void> restoreAllData(Map<String, dynamic> dbData) async {
  //   final collectReportEvents = await db.select(db.collectReportEvents).get();
  //   final eventOrders = await db.select(db.eventOrders).get();
  //   final eventRatios = await db.select(db.eventRatios).get();
  //   final eventTransactions = await db.select(db.eventTransactions).get();
  //   final events = await db.select(db.events).get();
  //   final guests = await db.select(db.guests).get();
  //   final members = await db.select(db.members).get();
  //   final menus = await db.select(db.menus).get();
  //   final ratios = await db.select(db.ratios).get();
  //   final reports = await db.select(db.reports).get();
  //   final teams = await db.select(db.teams).get();

  //   final collectReportEventsFromDbData = List<CollectReportEvent>.from(
  //     dbData['collectReportEvents'],
  //   );
  //   final eventOrdersFromDbData = List<EventOrder>.from(dbData['eventOrders']);
  //   final eventRatiosFromDbData = List<EventRatio>.from(dbData['eventRatios']);
  //   final eventTransactionsFromDbData = List<EventTransaction>.from(
  //     dbData['eventTransactions'],
  //   );
  //   final eventsFromDbData = List<Event>.from(dbData['events']);
  //   final guestsFromDbData = List<Guest>.from(dbData['guests']);
  //   final membersFromDbData = List<Member>.from(dbData['members']);
  //   final menusFromDbData = List<MenusData>.from(dbData['menus']);
  //   final ratiosFromDbData = List<Ratio>.from(dbData['ratios']);
  //   final reportsFromDbData = List<Report>.from(dbData['reports']);
  //   final teamsFromDbData = List<Team>.from(dbData['teams']);

  //   return;
  // }

  Future<Uint8List> exportBackup() async {
    final Map<String, dynamic> wrapper = {'tables': <String, dynamic>{}};
    final allTables = db.allTables; // List<TableInfo>

    for (final table in allTables) {
      final tableName = table.actualTableName;
      final rows = <Map<String, dynamic>>[];
      final result = await db.customSelect('SELECT * FROM "$tableName"').get();

      for (final row in result) {
        final map = Map<String, dynamic>.from(row.data);
        // encode binary (Uint8List) as base64
        map.forEach((k, v) {
          if (v is Uint8List) {
            map[k] = {'__blob_base64': base64Encode(v)};
          }
        });
        rows.add(map);
      }
      wrapper['tables'][tableName] = rows;
    }

    final jsonString = jsonEncode(wrapper);
    final bytes = Uint8List.fromList(utf8.encode(jsonString));
    // final filename = 'backup_${DateTime.now().toIso8601String()}.json';

    // return BackupResult(bytes: bytes, suggestedFilename: filename);
    return bytes;
  }

  Future<BackupReport> importBackup(
    Uint8List jsonBytes, {
    ProgressCallback? onProgress,
  }) async {
    final jsonString = utf8.decode(jsonBytes);
    final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
    final tablesPayload = (parsed['tables'] as Map).cast<String, dynamic>();

    // Available DB tables (from generated Drift DB)
    final availableTables = {for (final t in db.allTables) t.actualTableName};

    // Filter payload to existing tables only
    final payloadTables = <String, List<Map<String, dynamic>>>{};
    for (final entry in tablesPayload.entries) {
      if (!availableTables.contains(entry.key)) continue;
      final rows = (entry.value as List).cast<Map<String, dynamic>>();
      payloadTables[entry.key] = rows
          .map((r) => Map<String, dynamic>.from(r))
          .toList();
    }

    // Prepare report structure
    final perTable = <String, TableReport>{};
    final globalErrors = <String>[];

    // Run import inside a transaction
    await db.transaction(() async {
      // Temporarily disable foreign keys to avoid ordering issues
      try {
        await db.customStatement('PRAGMA foreign_keys = OFF;');
      } catch (_) {}

      // Precompute PK columns for payload tables
      final pkCache = <String, List<String>>{};
      for (final table in payloadTables.keys) {
        pkCache[table] = await _getPrimaryKeyColumns(table);
        perTable[table] = TableReport();
      }

      // Process each table in payload in arbitrary order (FK disabled)
      for (final table in payloadTables.keys) {
        final rows = payloadTables[table]!;
        final total = rows.length;
        var processed = 0;

        for (final rawRow in rows) {
          try {
            final result = await _upsertRow(table, rawRow, pkCache[table]!);
            final tr = perTable[table]!;
            if (result == 'inserted') {
              tr.inserted++;
            } else if (result == 'updated') {
              tr.updated++;
            } else if (result == 'skipped') {
              tr.skipped++;
            }
          } catch (e, _) {
            final msg =
                'Table=$table RowIndex=$processed Error=${e.toString()}';
            perTable[table]!.errors.add(msg);
            globalErrors.add(msg);
          } finally {
            processed++;
            if (onProgress != null) {
              try {
                onProgress(table, processed, total);
              } catch (_) {}
            }
          }
        }
      }

      // Re-enable foreign keys
      try {
        await db.customStatement('PRAGMA foreign_keys = ON;');
      } catch (_) {}
    });

    return BackupReport(perTable: perTable, globalErrors: globalErrors);
  }

  // Helper: get primary key columns for a table
  Future<List<String>> _getPrimaryKeyColumns(String table) async {
    final info = await db.customSelect('PRAGMA table_info("$table");').get();
    // PRAGMA table_info returns rows with 'name' and 'pk' (0/1/position)
    final pkCols = <Map<int, String>>[];
    for (final row in info) {
      final pk = row.data['pk'];
      if (pk is int && pk > 0) {
        // pk is position; store to sort by position
        pkCols.add({pk: row.data['name'] as String});
      }
    }
    pkCols.sort((a, b) => a.keys.first.compareTo(b.keys.first));
    return pkCols.map((m) => m.values.first).toList();
  }

  // // Helper: get foreign key dependencies (tables referenced by this table)
  // Future<List<String>> _getReferencedTables(String table) async {
  //   final fkRows = await db
  //       .customSelect('PRAGMA foreign_key_list("$table");')
  //       .get();
  //   final refs = <String>{};
  //   for (final r in fkRows) {
  //     final refTable = r.data['table'];
  //     if (refTable is String) refs.add(refTable);
  //   }
  //   return refs.toList();
  // }

  // Helper to decode BLOB placeholders back to Uint8List
  dynamic _decodeValue(dynamic v) {
    if (v is Map && v.length == 1 && v.containsKey('__blob_base64')) {
      return base64Decode(v['__blob_base64'] as String);
    }
    return v;
  }

  // Helper: convert dynamic value to a Drift Variable
  Variable _toVariable(Object? value) {
    // if (value == null) return Variable.withNull();
    if (value is int) return Variable.withInt(value);
    if (value is double) return Variable.withReal(value);
    if (value is String) return Variable.withString(value);
    if (value is bool) return Variable.withBool(value);
    if (value is DateTime) return Variable.withDateTime(value);
    if (value is Uint8List) return Variable.withBlob(value);
    // Fallback: stringify
    return Variable.withString(value.toString());
  }

  // Upsert single row; returns 'inserted'|'updated'|'skipped'
  Future<String> _upsertRow(
    String table,
    Map<String, dynamic> rawRow,
    List<String> pkCols,
  ) async {
    final row = <String, dynamic>{};
    rawRow.forEach((k, v) => row[k] = _decodeValue(v));

    // No PK -> insert
    if (pkCols.isEmpty) {
      final columns = row.keys.toList();
      final colList = columns.map((c) => '"$c"').join(', ');
      final placeholders = List.filled(columns.length, '?').join(', ');
      final insertSql =
          'INSERT INTO "$table" ($colList) VALUES ($placeholders);';
      final args = columns.map((c) => row[c]).toList();
      await db.customStatement(insertSql, args);
      return 'inserted';
    }

    // Build WHERE clause for PK
    final whereClauses = <String>[];
    final whereArgs = <Object?>[];
    var pkHasNull = false;
    for (final pk in pkCols) {
      final val = row.containsKey(pk) ? row[pk] : null;
      if (val == null) pkHasNull = true;
      whereClauses.add('"$pk" = ?');
      whereArgs.add(val);
    }

    // If any PK null -> insert
    if (pkHasNull) {
      final columns = row.keys.toList();
      final colList = columns.map((c) => '"$c"').join(', ');
      final placeholders = List.filled(columns.length, '?').join(', ');
      final insertSql =
          'INSERT INTO "$table" ($colList) VALUES ($placeholders);';
      final args = columns.map((c) => row[c]).toList();
      await db.customStatement(insertSql, args);
      return 'inserted';
    }

    // Check existence
    final selectSql =
        'SELECT * FROM "$table" WHERE ${whereClauses.join(' AND ')} LIMIT 1;';
    final variables = whereArgs.map((a) => _toVariable(a)).toList();
    final existing = await db
        .customSelect(selectSql, variables: variables)
        .get();

    if (existing.isEmpty) {
      // Insert
      final columns = row.keys.toList();
      final colList = columns.map((c) => '"$c"').join(', ');
      final placeholders = List.filled(columns.length, '?').join(', ');
      final insertSql =
          'INSERT INTO "$table" ($colList) VALUES ($placeholders);';
      final args = columns.map((c) => row[c]).toList();
      await db.customStatement(insertSql, args);
      return 'inserted';
    } else {
      // Update only changed non-PK columns
      final existingMap = Map<String, dynamic>.from(existing.first.data);
      final updateColumns = <String>[];
      final updateArgs = <Object?>[];
      var differs = false;

      for (final col in row.keys) {
        final incoming = row[col];
        final existingVal = existingMap[col];

        dynamic normIncoming = incoming;
        dynamic normExisting = existingVal;
        if (incoming is Uint8List) normIncoming = base64Encode(incoming);
        if (existingVal is Uint8List) normExisting = base64Encode(existingVal);

        if (normIncoming != normExisting) {
          if (!pkCols.contains(col)) {
            updateColumns.add('"$col" = ?');
            updateArgs.add(incoming);
          }
          differs = true;
        }
      }

      if (differs && updateColumns.isNotEmpty) {
        final updateSql =
            'UPDATE "$table" SET ${updateColumns.join(', ')} WHERE ${whereClauses.join(' AND ')};';
        final args = [...updateArgs, ...whereArgs];
        await db.customStatement(updateSql, args);
        return 'updated';
      } else {
        return 'skipped';
      }
    }
  }
}
