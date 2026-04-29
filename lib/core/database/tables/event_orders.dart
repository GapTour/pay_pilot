import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/members.dart';

class EventOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get memberID => integer().nullable().references(
    Members,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get guessID => integer().nullable().references(
    Members,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isDelivered => boolean().withDefault(const Constant(false))();
  TextColumn get menuItems => text().nullable()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
