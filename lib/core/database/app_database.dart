import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/database/schema_versions.dart';
import 'package:pay_pilot/core/database/tables/collect_report_events.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Events,
    Members,
    Reports,
    Ratios,
    Teams,
    CollectReportEvents,
    EventTransactions,
    EventRatios,
  ],
  daos: [ReportDao, RatioDao, EventDao, TeamDao, MemberDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.ratios);
          await m.createTable(schema.teams);
          await m.createTable(schema.collectReportEvents);
          await m.createTable(schema.eventTransactions);

          if (!await columnExists('members', 'joinAt')) {
            await m.addColumn(schema.members, schema.members.joinAt);
          }
          if (await columnExists('members', 'percentage')) {
            await m.dropColumn(schema.members, 'percentage');
          }

          await m.renameTable(schema.events, 'incomes');
          if (await columnExists('events', 'amount')) {
            await m.dropColumn(schema.events, 'amount');
          }
          if (!await columnExists('events', 'teamID')) {
            await m.addColumn(schema.events, schema.events.teamID);
          }

          if (await columnExists('reports', 'date')) {
            await m.renameColumn(
              schema.reports,
              'date',
              schema.reports.generateFor,
            );
          }
          if (await columnExists('reports', 'membersReport')) {
            await m.dropColumn(schema.reports, 'membersReport');
          }
          if (await columnExists('reports', 'totalBalance')) {
            await m.dropColumn(schema.reports, 'totalBalance');
          }
        },
        from2To3: (m, schema) async {
          await m.createTable(schema.eventRatios);
        },
      ),
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }

  Future<bool> columnExists(String table, String column) async {
    final result = await customSelect('PRAGMA table_info($table);').get();
    return result.any((row) => row.data['name'] == column);
  }
}

// dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/drift_schemas/
// dart run drift_dev schema steps lib/core/database/drift_schemas/ lib/core/database/schema_versions.dart
