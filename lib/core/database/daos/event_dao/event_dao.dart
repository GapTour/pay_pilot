import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_form.dart';
import 'package:pay_pilot/features/events/data/event_edit_form.dart';
import 'package:pay_pilot/features/events/data/event_form.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [Events, Teams, EventTransactions])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(super.db);

  Future<List<EventModel>> getAllEvents() async {
    final query = select(
      events,
    ).join([innerJoin(teams, teams.id.equalsExp(events.teamID))]);

    final rows = await query.get();

    return rows.map((row) {
      return EventModel(
        id: row.readTable(events).id,
        title: row.readTable(events).title,
        description: row.readTable(events).description,
        date: row.readTable(events).date,
        team: row.readTable(teams),
      );
    }).toList();
  }

  Future<EventDetailsModel> getEvent(int id) async {
    final eventQuery = (select(events)..where((tbl) => tbl.id.equals(id))).join(
      [innerJoin(teams, teams.id.equalsExp(events.teamID))],
    );
    final rowEvent = await eventQuery.getSingle();

    final List<EventTransaction> rawTransactions = await (select(
      eventTransactions,
    )..where((tbl) => tbl.eventID.equals(id))).get();

    return EventDetailsModel(
      id: rowEvent.readTable(events).id,
      title: rowEvent.readTable(events).title,
      description: rowEvent.readTable(events).description,
      transactions: rawTransactions.map((e) {
        return Transactions(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
        );
      }).toList(),
      date: rowEvent.readTable(events).date,
      team: rowEvent.readTable(teams),
    );
  }

  Future<List<EventDetailsModel>> getAllEventDetails() async {
    final List<EventDetailsModel> eventDetails = [];
    final eventQuery = select(
      events,
    ).join([innerJoin(teams, teams.id.equalsExp(events.teamID))]);
    final rowEvent = await eventQuery.get();

    for (var row in rowEvent) {
      final List<EventTransaction> rawTransactions = await (select(
        eventTransactions,
      )..where((tbl) => tbl.eventID.equals(row.readTable(events).id))).get();

      final List<Transactions> transactions = rawTransactions.map((e) {
        return Transactions(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
        );
      }).toList();

      eventDetails.add(
        EventDetailsModel(
          id: row.readTable(events).id,
          title: row.readTable(events).title,
          description: row.readTable(events).description,
          transactions: transactions,
          date: row.readTable(events).date,
          team: row.readTable(teams),
        ),
      );
    }

    return eventDetails;
  }

  // Future<int> insertEvent(EventForm event) async {
  //   return await db
  //       .into(db.events)
  //       .insert(
  //         EventsCompanion(
  //           title: Value(event.title),
  //           teamID: Value(event.teamID),
  //           date: Value(event.date),
  //           description: Value(event.description),
  //         ),
  //       );
  // }

  Future<int> insertEvent(EventForm event) async {
    return await db
        .into(db.events)
        .insert(
          EventsCompanion(
            title: Value(event.title),
            teamID: Value(event.teamID),
            date: Value(event.date),
            description: Value(event.description),
          ),
        );
  }

  Future<int> insertTransaction(TransactionForm transaction) async {
    return await db
        .into(db.eventTransactions)
        .insert(
          EventTransactionsCompanion(
            amount: Value(transaction.amount),
            eventID: Value(transaction.eventID),
            transactionType: Value(transaction.transactionType),
            date: Value(transaction.date),
            description: Value(transaction.description),
          ),
        );
  }

  Future<void> updateEvent(EventEditForm event) async {
    await (db.update(db.events)..where((tbl) => tbl.id.equals(event.id))).write(
      EventsCompanion(
        title: Value(event.title),
        teamID: Value(event.teamID),
        date: Value(event.date),
        description: Value(event.description),
      ),
    );
  }

  Future<void> updateTransaction(TransactionEditForm transaction) async {
    await (db.update(
      db.eventTransactions,
    )..where((tbl) => tbl.id.equals(transaction.id))).write(
      EventTransactionsCompanion(
        amount: Value(transaction.amount),
        eventID: Value(transaction.eventID),
        transactionType: Value(transaction.transactionType),
        date: Value(transaction.date),
        description: Value(transaction.description),
      ),
    );
  }

  Future<void> deleteIncome(int id) async {
    await (db.delete(db.events)..where((tbl) => tbl.id.equals(id))).go();
  }
}
