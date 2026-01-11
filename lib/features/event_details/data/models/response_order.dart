import 'dart:convert';

class ResponseOrder {
  final int id;
  final int? orderedByMember;
  final int? orderedByGuest;
  final int eventID;
  final List<int> orders;
  final bool isDelivered;

  ResponseOrder({
    required this.id,
    required this.orderedByMember,
    required this.orderedByGuest,
    required this.orders,
    required this.eventID,
    required this.isDelivered,
  });

  factory ResponseOrder.fromMap(Map<String, dynamic> map) {
    final orders = map['menuItems'] != null
        ? List<int>.from(jsonDecode(map['menuItems'] as String))
        : <int>[];

    return ResponseOrder(
      id: int.parse(map['id'] as String),
      eventID: int.parse(map['event_id'] as String),
      orderedByGuest: map['guest_id'] != null
          ? int.tryParse(map['guest_id'] as String)
          : null,
      orderedByMember: map['member_id'] != null
          ? int.tryParse(map['member_id'] as String)
          : null,
      orders: orders,
      isDelivered: map['is_delivered'] != null
          ? map['is_delivered'] as String == '1'
          : false,
    );
  }
}
