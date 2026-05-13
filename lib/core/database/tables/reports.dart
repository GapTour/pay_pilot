import 'package:drift/drift.dart';

class Reports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get version => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get generateFor => dateTime().withDefault(currentDate)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDate)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
