import 'package:drift/drift.dart';

class Reports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get version => integer()();
  TextColumn get description => text().nullable()();
  TextColumn get membersReport => text()();
  RealColumn get totalBalance => real()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
