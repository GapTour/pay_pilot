import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/order_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_orders.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_stories.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_story.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

part 'event_details_dao.g.dart';

@DriftAccessor(
  tables: [
    Events,
    Teams,
    EventTransactions,
    EventRatios,
    Ratios,
    EventOrders,
    EventStories,
  ],
)
class EventDetailsDao extends DatabaseAccessor<AppDatabase>
    with _$EventDetailsDaoMixin {
  EventDetailsDao(super.db);

  Future<List<EventDetailsModel>>
  getEventsWithoutMembersBalanceAndRatios() async {
    final List<EventDetailsModel> eventDetails = [];

    final rowEvents =
        await (((select(events))..where((tbl) => tbl.isActive.equals(true)))
                .join([innerJoin(teams, teams.id.equalsExp(events.teamID))]))
            .get();

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
          attachment: e.attachment,
          paidByGuest: e.guestID,
          paidByMember: e.memberID,
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

  Future<ResponseEventDetails> getEventInfoWithoutBalance(int id) async {
    final rowEvent =
        await ((select(events)..where((tbl) => tbl.id.equals(id))).join([
          innerJoin(teams, teams.id.equalsExp(events.teamID)),
        ])).getSingle();

    final rawEventRatios =
        await ((select(
              eventRatios,
            )..where((tbl) => tbl.eventID.equals(id))).join([
              innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
            ]))
            .get();

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
        attachment: e.attachment,
        paidByGuest: e.guestID,
        paidByMember: e.memberID,
      );
    }).toList();

    final rawEventOrders =
        await ((select(
              eventOrders,
            )..where((tbl) => tbl.eventID.equals(id))).join([
              leftOuterJoin(
                members,
                members.id.equalsExp(eventOrders.memberID),
              ),
              leftOuterJoin(guests, guests.id.equalsExp(eventOrders.guessID)),
            ]))
            .get();

    final orders = rawEventOrders.map((row) {
      final List<int> orders = [];
      final rawOrders = row.readTableOrNull(eventOrders)?.menuItems;

      if (rawOrders != null && jsonDecode(rawOrders) is List) {
        orders.addAll(List<int>.from(jsonDecode(rawOrders)));
      }

      return OrderModel(
        id: row.readTable(eventOrders).id,
        eventID: id,
        guest: row.readTableOrNull(guests),
        member: row.readTableOrNull(members),
        isDelivered: row.readTable(eventOrders).isDelivered,
        orders: orders,
      );
    }).toList();

    final List<EventStory> rawStories = await (select(
      eventStories,
    )..where((tbl) => tbl.eventID.equals(id))).get();

    final List<ResponseEventStory> stories = rawStories.map((e) {
      return ResponseEventStory(
        id: e.id,
        title: e.title,
        encodedText: e.encodedText,
        createAt: e.createAt,
        updateAt: e.modifiedAt,
      );
    }).toList();

    return ResponseEventDetails(
      id: rowEvent.readTable(events).id,
      title: rowEvent.readTable(events).title,
      description: rowEvent.readTable(events).description,
      transactions: transactions.map(ResponseEventTransaction.fromDb).toList(),
      date: rowEvent.readTable(events).date,
      team: ResponseTeam.fromDb(rowEvent.readTable(teams)),
      memberRatios: ratiosList.map(ResponseEventRatio.fromDb).toList(),
      orders: orders.map(ResponseOrder.fromDb).toList(),
      stories: stories,
    );
  }

  Future<List<ResponseEventDetails>> getAllEventsInfoWithoutBalance() async {
    final responses = <ResponseEventDetails>[];
    final eventRows =
        await (((select(events))..where((tbl) => tbl.isActive.equals(true)))
                .join([innerJoin(teams, teams.id.equalsExp(events.teamID))]))
            .get();

    for (var er in eventRows) {
      final id = er.readTable(events).id;

      final rawEventRatios =
          await ((select(
                eventRatios,
              )..where((tbl) => tbl.eventID.equals(id))).join([
                innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
              ]))
              .get();

      final List<MemberRatioModel> ratiosList = rawEventRatios.map((e) {
        return MemberRatioModel(
          id: e.readTable(eventRatios).id,
          ratio: e.readTable(eventRatios).ratio,
          member: e.readTable(members),
        );
      }).toList();

      if (ratiosList.isEmpty) {
        final backupRatiosList = await _handleNullEventRatio(
          er.readTable(teams).id,
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
          attachment: e.attachment,
          paidByGuest: e.guestID,
          paidByMember: e.memberID,
        );
      }).toList();

      final rawEventOrders =
          await ((select(
                eventOrders,
              )..where((tbl) => tbl.eventID.equals(id))).join([
                innerJoin(members, members.id.equalsExp(eventOrders.memberID)),
                innerJoin(guests, guests.id.equalsExp(eventOrders.guessID)),
              ]))
              .get();

      final orders = rawEventOrders.map((row) {
        final List<int> orders = [];
        final rawOrders = row.readTableOrNull(eventOrders)?.menuItems;

        if (rawOrders != null && jsonDecode(rawOrders) is List) {
          orders.addAll(jsonDecode(rawOrders));
        }

        return OrderModel(
          id: row.readTable(eventOrders).id,
          eventID: id,
          guest: row.readTableOrNull(guests),
          member: row.readTableOrNull(members),
          isDelivered: row.readTable(eventOrders).isDelivered,
          orders: orders,
        );
      }).toList();

      final List<EventStory> rawStories = await (select(
        eventStories,
      )..where((tbl) => tbl.eventID.equals(id))).get();

      final List<ResponseEventStory> stories = rawStories.map((e) {
        return ResponseEventStory(
          id: e.id,
          title: e.title,
          encodedText: e.encodedText,
          createAt: e.createAt,
          updateAt: e.modifiedAt,
        );
      }).toList();

      responses.add(
        ResponseEventDetails(
          id: er.readTable(events).id,
          title: er.readTable(events).title,
          description: er.readTable(events).description,
          transactions: transactions
              .map(ResponseEventTransaction.fromDb)
              .toList(),
          date: er.readTable(events).date,
          team: ResponseTeam.fromDb(er.readTable(teams)),
          memberRatios: ratiosList.map(ResponseEventRatio.fromDb).toList(),
          orders: orders.map(ResponseOrder.fromDb).toList(),
          stories: stories,
        ),
      );
    }

    return responses;
  }

  Future<EventDetailsModel> getEventInfo(int id) async {
    final rowEvent =
        await ((select(events)..where((tbl) => tbl.id.equals(id))).join([
          innerJoin(teams, teams.id.equalsExp(events.teamID)),
        ])).getSingle();

    final rawEventRatios =
        await ((select(
              eventRatios,
            )..where((tbl) => tbl.eventID.equals(id))).join([
              innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
            ]))
            .get();

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
        attachment: e.attachment,
        paidByGuest: e.guestID,
        paidByMember: e.memberID,
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
}
