import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/order_model.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_orders.dart';

part 'event_orders_dao.g.dart';

@DriftAccessor(tables: [EventOrders])
class EventOrdersDao extends DatabaseAccessor<AppDatabase>
    with _$EventOrdersDaoMixin {
  EventOrdersDao(super.db);

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
      EventOrdersCompanion(
        isDelivered: Value(isDelivered),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
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
        modifiedAt: Value(DateTime.now().toUtc()),
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
