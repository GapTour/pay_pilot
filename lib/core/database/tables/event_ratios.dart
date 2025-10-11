import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/members.dart';

class EventRatios extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get memberID =>
      integer().references(Members, #id, onDelete: KeyAction.cascade)();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  RealColumn get ratio => real()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
