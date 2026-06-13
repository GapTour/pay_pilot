import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';

part 'events_dao.g.dart';

@DriftAccessor(tables: [Events, Teams, Ratios, EventRatios])
class EventsDao extends DatabaseAccessor<AppDatabase> with _$EventsDaoMixin {
  EventsDao(super.db);

  Future<List<EventModel>> getAllEvents() async {
    final query = (select(db.events)..where((tbl) => tbl.isActive.equals(true)))
        .join([innerJoin(teams, teams.id.equalsExp(events.teamID))]);

    final rows = await query.get();

    return rows.map((row) {
      return EventModel(
        id: row.readTable(events).id,
        title: row.readTable(events).title,
        description: row.readTable(events).description,
        date: row.readTable(events).date,
        team: row.readTable(teams),
        isActive: row.readTable(events).isActive,
      );
    }).toList();
  }

  Future<int> insertEvent(EventParams event) async {
    final teamRatio = await (select(
      ratios,
    )..where((tbl) => tbl.teamID.equals(event.teamID))).get();

    int eventID = await db
        .into(db.events)
        .insert(
          EventsCompanion(
            title: Value(event.title),
            teamID: Value(event.teamID),
            date: Value(event.date),
            description: Value(event.description),
          ),
        );

    for (var element in teamRatio) {
      await into(eventRatios).insert(
        EventRatiosCompanion(
          eventID: Value(eventID),
          memberID: Value(element.memberID),
          ratio: Value(element.ratio),
        ),
      );
    }

    return eventID;
  }

  Future<void> updateEvent(EventParams event) async {
    final previousTeam = (await (select(
      events,
    )..where((tbl) => tbl.id.equals(event.id!))).getSingle()).teamID;

    if (previousTeam != event.teamID) {
      await (db.delete(
        eventRatios,
      )..where((tbl) => tbl.eventID.equals(event.id!))).go();

      final teamRatio = await (select(
        ratios,
      )..where((tbl) => tbl.teamID.equals(event.teamID))).get();

      for (var element in teamRatio) {
        await into(eventRatios).insert(
          EventRatiosCompanion(
            eventID: Value(event.id!),
            memberID: Value(element.memberID),
            ratio: Value(element.ratio),
          ),
        );
      }
    }

    await (db.update(
      db.events,
    )..where((tbl) => tbl.id.equals(event.id!))).write(
      EventsCompanion(
        title: Value(event.title),
        teamID: Value(event.teamID),
        date: Value(event.date),
        description: Value(event.description),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> archiveEvent(int id) async {
    await (db.update(db.events)..where((tbl) => tbl.id.equals(id))).write(
      EventsCompanion(
        isActive: Value(false),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> deleteEvent(int id) async {
    await (db.delete(db.events)..where((tbl) => tbl.id.equals(id))).go();
  }
}
