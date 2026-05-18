import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/guests.dart';

part 'guest_dao.g.dart';

@DriftAccessor(tables: [Guests])
class GuestDao extends DatabaseAccessor<AppDatabase> with _$GuestDaoMixin {
  GuestDao(super.db);

  Future<int> insertGuess(GuestParams guest) async {
    return await db
        .into(db.guests)
        .insert(
          GuestsCompanion(
            name: Value(guest.name),
            phoneNumber: Value(guest.phone),
            telegramId: Value(guest.telegramID),
            instagramId: Value(guest.instagramID),
            description: Value(guest.description),
            birthday: Value(guest.birthday),
            profileImage: Value(guest.profileImage),
          ),
        );
  }

  Future<List<Guest>> getAllGuests() async {
    return await (db.select(
      db.guests,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  Future<Guest> getGuest(int id) async {
    return (db.select(
      db.guests,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateGuest(GuestParams guest) async {
    await (db.update(
      db.guests,
    )..where((tbl) => tbl.id.equals(guest.id!))).write(
      GuestsCompanion(
        name: Value(guest.name),
        phoneNumber: Value(guest.phone),
        telegramId: Value(guest.telegramID),
        instagramId: Value(guest.instagramID),
        description: Value(guest.description),
        birthday: Value(guest.birthday),
        profileImage: Value(guest.profileImage),
        isActive: Value(guest.isActive ?? true),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> archiveGuest(int id) async {
    await (db.update(db.guests)..where((tbl) => tbl.id.equals(id))).write(
      GuestsCompanion(
        isActive: Value(false),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> deleteGuest(int id) async {
    await (db.delete(db.guests)..where((tbl) => tbl.id.equals(id))).go();
  }
}
