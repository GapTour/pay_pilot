import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_orders.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';

part 'event_transactions_dao.g.dart';

@DriftAccessor(tables: [EventTransactions, EventOrders])
class EventTransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$EventTransactionsDaoMixin {
  EventTransactionsDao(super.db);

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
              if (notEditedTransaction.guestID != null) {
                return tbl.eventID.equals(notEditedTransaction.eventID) &
                    tbl.guessID.equalsNullable(notEditedTransaction.guestID);
              } else if (notEditedTransaction.memberID != null) {
                return tbl.eventID.equals(notEditedTransaction.eventID) &
                    tbl.memberID.equalsNullable(notEditedTransaction.memberID);
              }
              return tbl.eventID.equals(0);
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
        modifiedAt: Value(DateTime.now().toUtc()),
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

      if (notEditedOrderInfo != null) await _deleteOrder(notEditedOrderInfo.id);
      if (transaction.transactionType.isIncome) {
        await _insertOrder(
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

      if (notEditedOrderInfo != null) await _deleteOrder(notEditedOrderInfo.id);
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
            modifiedAt: Value(DateTime.now().toUtc()),
          ),
        );
        return;
      }
      await _insertOrder(
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
      await _deleteOrder(notEditedOrderInfo.id);
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

  Future<int> _insertOrder(EventOrderParams eventOrder) async {
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

  Future<void> _deleteOrder(int id) async {
    await (db.delete(eventOrders)..where((tbl) => tbl.id.equals(id))).go();
  }
}
