import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_form.dart';
import 'package:pay_pilot/features/events/data/event_edit_form.dart';
import 'package:pay_pilot/features/events/data/event_form.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [Events, Teams, EventTransactions, EventRatios, Ratios])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(super.db);

  Future<List<EventModel>> getAllEvents() async {
    final query = select(
      db.events,
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

  Future<List<EventDetailsModel>>
  getEventsWithoutMembersBalanceAndRatios() async {
    final List<EventDetailsModel> eventDetails = [];

    final rowEvents = await ((select(
      events,
    )).join([innerJoin(teams, teams.id.equalsExp(events.teamID))])).get();

    for (var element in rowEvents) {
      final List<EventTransaction> rawTransactions =
          await (select(eventTransactions)..where(
                (tbl) => tbl.eventID.equals(element.readTable(events).id),
              ))
              .get();

      final List<TransactionModel> transactions = rawTransactions.map((e) {
        return TransactionModel(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
        );
      }).toList();

      eventDetails.add(
        EventDetailsModel(
          id: element.readTable(events).id,
          title: element.readTable(events).title,
          description: element.readTable(events).description,
          transactions: transactions,
          date: element.readTable(events).date,
          team: element.readTable(teams),
          memberRatios: [],
          membersBalance: [],
        ),
      );
    }

    return eventDetails;
  }

  Future<EventDetailsModel> getEventInfo(int id) async {
    final rowEvent =
        await ((select(events)..where((tbl) => tbl.id.equals(id))).join([
          innerJoin(teams, teams.id.equalsExp(events.teamID)),
        ])).getSingle();

    final rawEventRatios = await (select(eventRatios).join([
      innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
    ])).get();

    final List<MemberRatioModel> ratiosList = rawEventRatios.map((e) {
      return MemberRatioModel(
        id: e.readTable(eventRatios).id,
        ratio: e.readTable(eventRatios).ratio,
        member: e.readTable(members),
      );
    }).toList();

    if (ratiosList.isEmpty) {
      final backupRatiosList = await _handleNullEventRatio(
        rowEvent.readTable(teams).id,
        id,
      );

      ratiosList.addAll(backupRatiosList);
    }

    final List<EventTransaction> rawTransactions = await (select(
      eventTransactions,
    )..where((tbl) => tbl.eventID.equals(id))).get();

    final List<TransactionModel> transactions = rawTransactions.map((e) {
      return TransactionModel(
        id: e.id,
        description: e.description,
        amount: e.amount,
        transactionType: e.transactionType,
        date: e.date,
      );
    }).toList();

    final membersBalance = await CalculatorHelper.eventSalary(
      eventDetails: RawEventDetailsModel(
        id: id,
        transactions: transactions,
        memberRatios: ratiosList,
        team: rowEvent.readTable(teams),
      ),
    );

    return EventDetailsModel(
      id: rowEvent.readTable(events).id,
      title: rowEvent.readTable(events).title,
      description: rowEvent.readTable(events).description,
      transactions: transactions,
      date: rowEvent.readTable(events).date,
      team: rowEvent.readTable(teams),
      memberRatios: ratiosList,
      membersBalance: membersBalance,
    );
  }

  Future<List<MemberRatioModel>> _handleNullEventRatio(
    int teamID,
    int eventID,
  ) async {
    final List<MemberRatioModel> memberRatios = [];
    final rawTeamRatios =
        await ((select(ratios)..where((tbl) => tbl.teamID.equals(teamID))).join(
          [innerJoin(members, members.id.equalsExp(ratios.memberID))],
        )).get();

    for (var row in rawTeamRatios) {
      final int id = await db
          .into(eventRatios)
          .insert(
            EventRatiosCompanion(
              ratio: Value(row.readTable(ratios).ratio),
              memberID: Value(row.readTable(members).id),
              eventID: Value(eventID),
            ),
          );
      final member = await (select(
        members,
      )..where((tbl) => tbl.id.equals(row.readTable(members).id))).getSingle();

      memberRatios.add(
        MemberRatioModel(
          id: id,
          ratio: row.readTable(ratios).ratio,
          member: member,
        ),
      );
    }

    return memberRatios;
  }

  Future<int> insertEvent(EventForm event) async {
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

  Future<void> updateEvent(EventEditForm event) async {
    final previousTeam = (await (select(
      events,
    )..where((tbl) => tbl.id.equals(event.id))).getSingle()).teamID;

    if (previousTeam != event.teamID) {
      await (db.delete(
        eventRatios,
      )..where((tbl) => tbl.eventID.equals(event.id))).go();

      final teamRatio = await (select(
        ratios,
      )..where((tbl) => tbl.teamID.equals(event.teamID))).get();

      for (var element in teamRatio) {
        await into(eventRatios).insert(
          EventRatiosCompanion(
            eventID: Value(event.id),
            memberID: Value(element.memberID),
            ratio: Value(element.ratio),
          ),
        );
      }
    }

    await (db.update(db.events)..where((tbl) => tbl.id.equals(event.id))).write(
      EventsCompanion(
        title: Value(event.title),
        teamID: Value(event.teamID),
        date: Value(event.date),
        description: Value(event.description),
      ),
    );
  }

  Future<void> deleteEvent(int id) async {
    await (db.delete(db.events)..where((tbl) => tbl.id.equals(id))).go();
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

  Future<void> deleteTransaction(int id) async {
    await (db.delete(
      db.eventTransactions,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> insertRatio(EventRatioForm eventRatio) async {
    return await db
        .into(eventRatios)
        .insert(
          EventRatiosCompanion(
            ratio: Value(eventRatio.ratio),
            memberID: Value(eventRatio.member.id),
            eventID: Value(eventRatio.eventID),
          ),
        );
  }

  Future<void> updateRatio(EventRatioEditForm eventRatio) async {
    await (db.update(
      eventRatios,
    )..where((tbl) => tbl.id.equals(eventRatio.id))).write(
      EventRatiosCompanion(
        ratio: Value(eventRatio.ratio),
        memberID: Value(eventRatio.member.id),
        eventID: Value(eventRatio.eventID),
      ),
    );
  }

  Future<void> deleteRatio(int id) async {
    await (db.delete(eventRatios)..where((tbl) => tbl.id.equals(id))).go();
  }
}
