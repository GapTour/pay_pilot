import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';

class Ratios extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get memberID => integer().references(Members, #id)();
  IntColumn get teamID => integer().references(Teams, #id)();
  RealColumn get ratio => real()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
