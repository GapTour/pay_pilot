import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/menu_dao/menu_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/database/daos/settings_dao/settings_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/database/schema_versions.dart';
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
    Menus,
    Guests,
    EventOrders,
  ],
  daos: [
    ReportDao,
    RatioDao,
    EventDao,
    TeamDao,
    MemberDao,
    GuestDao,
    MenuDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 4;

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

          if (!await columnExists(m, 'members', 'joinAt')) {
            await m.addColumn(schema.members, schema.members.joinAt);
          }
          if (await columnExists(m, 'members', 'percentage')) {
            await m.dropColumn(schema.members, 'percentage');
          }

          await m.renameTable(schema.events, 'incomes');
          if (await columnExists(m, 'events', 'amount')) {
            await m.dropColumn(schema.events, 'amount');
          }
          if (!await columnExists(m, 'events', 'teamID')) {
            await m.addColumn(schema.events, schema.events.teamID);
          }

          if (await columnExists(m, 'reports', 'date')) {
            await m.renameColumn(
              schema.reports,
              'date',
              schema.reports.generateFor,
            );
          }
          if (await columnExists(m, 'reports', 'membersReport')) {
            await m.dropColumn(schema.reports, 'membersReport');
          }
          if (await columnExists(m, 'reports', 'totalBalance')) {
            await m.dropColumn(schema.reports, 'totalBalance');
          }
        },
        from2To3: (m, schema) async {
          await m.createTable(schema.eventRatios);
        },
        from3To4: (m, schema) async {
          await m.createTable(schema.eventOrders);
          await m.createTable(schema.guests);
          await m.createTable(schema.menus);

          await m.alterTable(
            TableMigration(
              schema.members,
              columnTransformer: {
                schema.members.isActive: Constant(true),
                schema.members.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [
                schema.members.isActive,
                schema.members.birthday,
                schema.members.profileImage,
                schema.members.modifiedAt,
              ],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.teams,
              columnTransformer: {
                schema.teams.isActive: Constant(true),
                schema.teams.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [schema.teams.isActive, schema.teams.modifiedAt],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.ratios,
              columnTransformer: {
                schema.ratios.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [schema.ratios.modifiedAt],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.events,
              columnTransformer: {
                schema.events.isActive: Constant(true),
                schema.events.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [schema.events.modifiedAt, schema.events.isActive],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.eventTransactions,
              columnTransformer: {
                schema.eventTransactions.modifiedAt: Constant(
                  DateTime.now().toUtc(),
                ),
              },
              newColumns: [
                schema.eventTransactions.modifiedAt,
                schema.eventTransactions.memberID,
                schema.eventTransactions.guestID,
                schema.eventTransactions.attachment,
              ],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.eventRatios,
              columnTransformer: {
                schema.eventRatios.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [schema.eventRatios.modifiedAt],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.reports,
              columnTransformer: {
                schema.reports.isActive: Constant(true),
                schema.reports.modifiedAt: Constant(DateTime.now().toUtc()),
              },
              newColumns: [schema.reports.modifiedAt, schema.reports.isActive],
            ),
          );

          await m.alterTable(
            TableMigration(
              schema.collectReportEvents,
              columnTransformer: {
                schema.collectReportEvents.modifiedAt: Constant(
                  DateTime.now().toUtc(),
                ),
              },
              newColumns: [schema.collectReportEvents.modifiedAt],
            ),
          );
        },
      ),
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }

  Future<bool> columnExists(
    Migrator m,
    String sqlTableName,
    String sqlColumnName,
  ) async {
    final rows = await m.database
        .customSelect('PRAGMA table_info("$sqlTableName");')
        .get();
    return rows.any((r) => r.data['name'] == sqlColumnName);
  }
}

// dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/drift_schemas/
// dart run drift_dev schema steps lib/core/database/drift_schemas/ lib/core/database/schema_versions.dart
