import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/order_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_orders.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

part 'event_dao.g.dart';

@DriftAccessor(
  tables: [Events, Teams, EventTransactions, EventRatios, Ratios, EventOrders],
)
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
        isActive: row.readTable(events).isActive,
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

    return ResponseEventDetails(
      id: rowEvent.readTable(events).id,
      title: rowEvent.readTable(events).title,
      description: rowEvent.readTable(events).description,
      transactions: transactions.map(ResponseEventTransaction.fromDb).toList(),
      date: rowEvent.readTable(events).date,
      team: ResponseTeam.fromDb(rowEvent.readTable(teams)),
      memberRatios: ratiosList.map(ResponseEventRatio.fromDb).toList(),
      orders: orders.map(ResponseOrder.fromDb).toList(),
    );
  }

  Future<List<ResponseEventDetails>> getAllEventsInfoWithoutBalance() async {
    final responses = <ResponseEventDetails>[];
    final eventRows = await ((select(
      events,
    )).join([innerJoin(teams, teams.id.equalsExp(events.teamID))])).get();

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
      ),
    );
  }

  Future<void> deleteEvent(int id) async {
    await (db.delete(db.events)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> insertTransaction(TransactionParams transaction) async {
    final transactionId = await db
        .into(db.eventTransactions)
        .insert(
          EventTransactionsCompanion(
            amount: Value(transaction.amount),
            eventID: Value(transaction.eventID),
            transactionType: Value(transaction.transactionType),
            date: Value(transaction.transactionDate),
            description: Value(transaction.description),
            guestID: Value(transaction.guestID),
            memberID: Value(transaction.memberID),
            attachment: Value(transaction.attachment),
          ),
        );

    if (transaction.guestID != null && transaction.transactionType.isIncome) {
      final alreadyHasOrder =
          await (db.select(db.eventOrders)..where((tbl) {
                return tbl.eventID.equals(transaction.eventID) &
                    tbl.guessID.equals(transaction.guestID!);
              }))
              .getSingleOrNull() !=
          null;

      if (alreadyHasOrder) return transactionId;

      await db
          .into(eventOrders)
          .insert(
            EventOrdersCompanion(
              eventID: Value(transaction.eventID),
              guessID: Value(transaction.guestID),
            ),
          );
    }

    return transactionId;
  }

  Future<void> updateTransaction(TransactionParams transaction) async {
    final notEditedTransaction = await (db.select(
      db.eventTransactions,
    )..where((tbl) => tbl.id.equals(transaction.id!))).getSingle();

    final notEditedOrderInfo =
        await (db.select(db.eventOrders)..where((tbl) {
              return tbl.eventID.equals(notEditedTransaction.eventID) &
                  (tbl.guessID.equalsNullable(notEditedTransaction.guestID) |
                      tbl.guessID.equalsNullable(
                        notEditedTransaction.memberID,
                      ));
            }))
            .getSingleOrNull();

    await (db.update(
      db.eventTransactions,
    )..where((tbl) => tbl.id.equals(transaction.id!))).write(
      EventTransactionsCompanion(
        amount: Value(transaction.amount),
        eventID: Value(transaction.eventID),
        transactionType: Value(transaction.transactionType),
        date: Value(transaction.transactionDate),
        description: Value(transaction.description),
      ),
    );

    if (notEditedTransaction.memberID != null && transaction.guestID == null) {
      /// it means it was member before and edited transaction also include
      /// member info again and do not need to do anything
      /// situations:
      /// 1. was member -> choose new member
      /// --- do nothing and return
      /// 2. was member -> same member
      /// --- do nothing and return
      return;
    }

    if (notEditedTransaction.memberID == null &&
        notEditedTransaction.guestID == null &&
        transaction.guestID == null) {
      /// it means it was nobody before and edited transaction also not include
      /// a guest info again and do not need to do anything
      /// situations:
      /// 3. was nobody -> choose new member/nobody
      /// --- do nothing and return
      return;
    }

    if (notEditedTransaction.memberID != null && transaction.guestID != null) {
      /// it means it was member before and edited transaction include
      /// a guest info and we need to create a new order
      /// situations:
      /// 4. was member -> choose guest instead
      /// --- check if its income then create an order

      if (notEditedOrderInfo != null) await deleteOrder(notEditedOrderInfo.id);
      if (transaction.transactionType.isIncome) {
        await insertOrder(
          EventOrderParams(
            id: null,
            eventID: transaction.eventID,
            memberID: null,
            guestID: transaction.guestID,
            menuItemIDs: [],
          ),
        );
      }
      return;
    }

    if (notEditedTransaction.guestID != null && transaction.guestID == null) {
      /// it means it was guest before and edited transaction include
      /// a member info/nobody and we need to remove order info
      /// situations:
      /// 5. was guest -> choose member instead
      /// --- remove the order info
      /// 6. was guest -> choose nobody
      /// --- remove the order info

      if (notEditedOrderInfo != null) await deleteOrder(notEditedOrderInfo.id);
      return;
    }

    if (notEditedTransaction.guestID != null &&
        transaction.guestID != notEditedTransaction.guestID) {
      /// it means it was guest before and edited transaction include
      /// a new guest info and we need to update order info
      /// situations:
      /// 7. was guest -> choose new guest
      /// --- update the order info

      if (notEditedOrderInfo != null) {
        await (db.update(
          eventOrders,
        )..where((tbl) => tbl.id.equals(notEditedOrderInfo.id))).write(
          EventOrdersCompanion(
            memberID: Value(transaction.memberID),
            eventID: Value(transaction.eventID),
            guessID: Value(transaction.guestID),
          ),
        );
        return;
      }
      await insertOrder(
        EventOrderParams(
          id: null,
          eventID: transaction.eventID,
          memberID: null,
          guestID: transaction.guestID,
          menuItemIDs: [],
        ),
      );
      return;
    }

    if (notEditedTransaction.guestID != null &&
        transaction.guestID == notEditedTransaction.guestID) {
      /// it means it was guest before and edited transaction include
      /// same guest info and we need to return and do nothing
      /// situations:
      /// 8. was guest -> same guest
      /// --- do nothing and return

      return;
    }

    if (transaction.transactionType.isExpense && notEditedOrderInfo != null) {
      await deleteOrder(notEditedOrderInfo.id);
      return;
    }
  }

  Future<void> deleteTransaction(TransactionParams transaction) async {
    await (db.delete(
      db.eventTransactions,
    )..where((tbl) => tbl.id.equals(transaction.id!))).go();

    if (transaction.hasPermissionDeleteOrder) {
      await (db.delete(eventOrders)..where((tbl) {
            return tbl.eventID.equals(transaction.eventID) &
                (tbl.guessID.equalsNullable(transaction.guestID) |
                    tbl.guessID.equalsNullable(transaction.memberID));
          }))
          .go();
    }
  }

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
      ),
    );
  }

  Future<void> deleteRatio(int id) async {
    await (db.delete(eventRatios)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<OrderModel>> getAllOrders(int eventID) async {
    final rawEventOrders =
        await ((select(
              eventOrders,
            )..where((tbl) => tbl.eventID.equals(eventID))).join([
              leftOuterJoin(
                members,
                members.id.equalsExp(eventOrders.memberID),
              ),
              leftOuterJoin(guests, guests.id.equalsExp(eventOrders.guessID)),
            ]))
            .get();

    return rawEventOrders.map((row) {
      final List<int> orders = [];
      final rawOrders = row.readTableOrNull(eventOrders)?.menuItems;

      if (rawOrders != null && jsonDecode(rawOrders) is List) {
        orders.addAll(List<int>.from(jsonDecode(rawOrders)));
      }

      return OrderModel(
        id: row.readTable(eventOrders).id,
        eventID: eventID,
        guest: row.readTableOrNull(guests),
        member: row.readTableOrNull(members),
        isDelivered: row.readTable(eventOrders).isDelivered,
        orders: orders,
      );
    }).toList();
  }

  Future<OrderModel> changeOrderDeliveryStatus(int id, bool isDelivered) async {
    await (db.update(eventOrders)..where((tbl) => tbl.id.equals(id))).write(
      EventOrdersCompanion(isDelivered: Value(isDelivered)),
    );

    final row =
        await ((select(eventOrders)..where((tbl) => tbl.id.equals(id))).join([
          leftOuterJoin(members, members.id.equalsExp(eventOrders.memberID)),
          leftOuterJoin(guests, guests.id.equalsExp(eventOrders.guessID)),
        ])).getSingle();

    final List<int> orders = [];
    final rawOrders = row.readTableOrNull(eventOrders)?.menuItems;

    if (rawOrders != null && jsonDecode(rawOrders) is List) {
      orders.addAll(List<int>.from(jsonDecode(rawOrders)));
    }

    return OrderModel(
      id: row.readTable(eventOrders).id,
      eventID: row.readTable(eventOrders).eventID,
      guest: row.readTableOrNull(guests),
      member: row.readTableOrNull(members),
      isDelivered: row.readTable(eventOrders).isDelivered,
      orders: orders,
    );
  }

  Future<int> insertOrder(EventOrderParams eventOrder) async {
    final menuItems = jsonEncode(eventOrder.menuItemIDs);

    return await db
        .into(eventOrders)
        .insert(
          EventOrdersCompanion(
            menuItems: Value(menuItems),
            memberID: Value(eventOrder.memberID),
            eventID: Value(eventOrder.eventID),
            guessID: Value(eventOrder.guestID),
          ),
        );
  }

  Future<OrderModel> updateOrder(EventOrderParams eventOrder) async {
    final menuItems = jsonEncode(eventOrder.menuItemIDs);

    await (db.update(
      eventOrders,
    )..where((tbl) => tbl.id.equals(eventOrder.id!))).write(
      EventOrdersCompanion(
        menuItems: Value(menuItems),
        memberID: Value(eventOrder.memberID),
        eventID: Value(eventOrder.eventID),
        guessID: Value(eventOrder.guestID),
      ),
    );

    final row =
        await ((select(
              eventOrders,
            )..where((tbl) => tbl.id.equals(eventOrder.id!))).join([
              leftOuterJoin(
                members,
                members.id.equalsExp(eventOrders.memberID),
              ),
              leftOuterJoin(guests, guests.id.equalsExp(eventOrders.guessID)),
            ]))
            .getSingle();

    final List<int> orders = [];
    final rawOrders = row.readTableOrNull(eventOrders)?.menuItems;

    if (rawOrders != null && jsonDecode(rawOrders) is List) {
      orders.addAll(List<int>.from(jsonDecode(rawOrders)));
    }

    return OrderModel(
      id: row.readTable(eventOrders).id,
      eventID: row.readTable(eventOrders).eventID,
      guest: row.readTableOrNull(guests),
      member: row.readTableOrNull(members),
      isDelivered: row.readTable(eventOrders).isDelivered,
      orders: orders,
    );
  }

  Future<void> deleteOrder(int id) async {
    await (db.delete(eventOrders)..where((tbl) => tbl.id.equals(id))).go();
  }
}
