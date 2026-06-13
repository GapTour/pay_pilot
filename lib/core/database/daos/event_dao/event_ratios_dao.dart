import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';

part 'event_ratios_dao.g.dart';

@DriftAccessor(tables: [EventRatios])
class EventRatiosDao extends DatabaseAccessor<AppDatabase>
    with _$EventRatiosDaoMixin {
  EventRatiosDao(super.db);

  Future<int> insertRatio(EventRatioParams eventRatio) async {
    return await db
        .into(eventRatios)
        .insert(
          EventRatiosCompanion(
            ratio: Value(eventRatio.ratioValue),
            memberID: Value(eventRatio.memberID),
            eventID: Value(eventRatio.eventID),
          ),
        );
  }

  Future<void> updateRatio(EventRatioParams eventRatio) async {
    await (db.update(
      eventRatios,
    )..where((tbl) => tbl.id.equals(eventRatio.id!))).write(
      EventRatiosCompanion(
        ratio: Value(eventRatio.ratioValue),
        memberID: Value(eventRatio.memberID),
        eventID: Value(eventRatio.eventID),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> deleteRatio(int id) async {
    await (db.delete(eventRatios)..where((tbl) => tbl.id.equals(id))).go();
  }
}
