import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';

class EventStories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  TextColumn get encodedText => text()();
  TextColumn get title => text()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDate)();
}
