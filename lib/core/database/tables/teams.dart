import 'package:drift/drift.dart';

class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDate)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
