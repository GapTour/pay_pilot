import 'package:drift/drift.dart';

class Guests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDate)();
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  TextColumn get telegramId => text().nullable()();
  TextColumn get instagramId => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
}
