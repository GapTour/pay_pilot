import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/schema_versions.dart';
import 'package:pay_pilot/core/database/tables/incomes.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Incomes, Members, Reports])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        // from1To2: (m, schema) async {
        //   await m.addColumn(publicInfos, publicInfos.first_launch);
        // },
        // from2To3: (m, schema) async {
        //   await m.addColumn(publicInfos, publicInfos.other);
        // },
      ),
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }
}

// dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/drift_schemas/
// dart run drift_dev schema steps lib/core/database/drift_schemas/ lib/core/database/schema_versions.dart
