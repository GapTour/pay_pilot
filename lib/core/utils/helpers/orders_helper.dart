import 'package:collection/collection.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class OrdersHelper {
  OrdersHelper._();

  static List<ResponseOrder> filterAllOrders(
    List<int> filteredOrders,
    List<ResponseOrder> allOrders,
  ) {
    final orders = <ResponseOrder>[];

    if (filteredOrders.isEmpty) {
      orders.addAll(allOrders);
    }
    if (filteredOrders.isNotEmpty) {
      bool hasFilterItems = false;
      final sumFilterOrderIds = filteredOrders.fold(0, (
        previousValue,
        current,
      ) {
        return previousValue + current;
      });

      for (var orderDetails in allOrders) {
        final currentOrders = orderDetails.orders;
        hasFilterItems = false;

        if (currentOrders.length != filteredOrders.length) continue;

        final sumOrderIds = currentOrders.fold(0, (previousValue, current) {
          return previousValue + current;
        });
        if (sumOrderIds != sumFilterOrderIds) continue;

        for (var orderId in currentOrders) {
          final hasItem = filteredOrders.any((id) => id == orderId);
          if (hasItem) hasFilterItems = true;
          if (!hasItem) {
            hasFilterItems = false;
            break;
          }
        }

        if (hasFilterItems) orders.add(orderDetails);
      }
    }

    return orders;
  }

  static int initSelectedOrderCategory(
    List<int> filteredOrders,
    List<(String, List<ResponseMenu>, int)> ordersOverview,
  ) {
    int selectedIndex = 0;
    bool containFilterId = false;
    final sumFilterOrderIds = filteredOrders.fold(0, (previousValue, current) {
      return previousValue + current;
    });

    if (filteredOrders.isNotEmpty) {
      for (var i = 0; i < ordersOverview.length; i++) {
        final currentOrder = ordersOverview[i];
        containFilterId = false;

        if (currentOrder.$2.length != filteredOrders.length) continue;

        final sumOrderIds = currentOrder.$2.fold(0, (previousValue, current) {
          return previousValue + current.id;
        });
        if (sumOrderIds != sumFilterOrderIds) continue;

        for (var responseMenu in currentOrder.$2) {
          final hasItem = filteredOrders.any((f) => f == responseMenu.id);
          if (hasItem) containFilterId = true;
          if (!hasItem) {
            containFilterId = false;
            break;
          }
        }

        if (containFilterId) {
          selectedIndex = i;
          break;
        }
      }
    }

    return selectedIndex;
  }

  static List<(String, List<ResponseMenu>, int)> calculateOrdersOverview(
    List<ResponseOrder> orders,
    List<ResponseMenu> menuItems,
  ) {
    final eq = const ListEquality<int>();
    final counts = <List<ResponseMenu>, int>{};

    for (var menus in orders.map((e) => e.orders)) {
      // Convert menu IDs → ResponseMenu objects
      final menuInfo = menus
          .map((menuId) => menuItems.firstWhereOrNull((m) => m.id == menuId))
          .whereType<ResponseMenu>()
          .toList();

      // Normalize: sort by ID so [1,2] and [2,1] become the same
      final normalized = [...menuInfo]..sort((a, b) => a.id.compareTo(b.id));

      // Find an existing key with the same normalized IDs
      final existingKey = counts.keys.firstWhereOrNull(
        (k) => eq.equals(
          k.map((t) => t.id).toList(),
          normalized.map((t) => t.id).toList(),
        ),
      );

      if (normalized.isEmpty) continue;

      if (existingKey != null) {
        counts[existingKey] = counts[existingKey]! + 1;
      } else {
        counts[normalized] = 1;
      }
    }

    return counts.entries
        .map((e) => (e.key.map((m) => m.title).join(', '), e.key, e.value))
        .toList();
  }
}
