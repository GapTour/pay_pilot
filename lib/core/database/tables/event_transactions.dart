import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/guests.dart';
import 'package:pay_pilot/core/database/tables/members.dart';

enum TransactionType {
  income,
  expense;

  bool get isIncome => this == TransactionType.income;
  bool get isExpense => this == TransactionType.expense;
}

class EventTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  TextColumn get transactionType => textEnum<TransactionType>()();
  IntColumn get eventID =>
      integer().references(Events, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  DateTimeColumn get modifiedAt => dateTime().withDefault(currentDate)();
  IntColumn get memberID => integer().nullable().references(
    Members,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get guestID => integer().nullable().references(
    Guests,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get attachment => text().nullable()();
}
