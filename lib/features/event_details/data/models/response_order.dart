import 'dart:convert';

import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class ResponseOrder {
  final int id;
  final int? orderedByMember;
  final int? orderedByGuest;
  final List<ResponseMenu> orders;

  ResponseOrder({
    required this.id,
    required this.orderedByMember,
    required this.orderedByGuest,
    required this.orders,
  });

  factory ResponseOrder.fromMap(Map<String, dynamic> map) {
    final orders = map['menuItems'] != null
        ? jsonDecode(map['menuItems'] as String)
        : <ResponseMenu>[];

    return ResponseOrder(
      id: int.parse(map['id'] as String),
      orderedByGuest: map['guest_id'] != null
          ? int.tryParse(map['guest_id'] as String)
          : null,
      orderedByMember: map['member_id'] != null
          ? int.tryParse(map['member_id'] as String)
          : null,
      orders: orders,
    );
  }
}
