import 'package:drift/drift.dart';

class Menus extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDate)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
