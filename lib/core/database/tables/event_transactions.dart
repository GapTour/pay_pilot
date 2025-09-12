import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';

enum TransactionType { income, expense }

class EventTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  TextColumn get transactionType => textEnum<TransactionType>()();
  IntColumn get eventID => integer().references(Events, #id)();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
}
