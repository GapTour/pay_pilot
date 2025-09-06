import 'package:drift/drift.dart';

class Incomes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
