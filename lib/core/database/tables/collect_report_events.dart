import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';

class CollectReportEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventID => integer().references(Events, #id)();
  IntColumn get reportID => integer().references(Reports, #id)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
