import 'package:pay_pilot/core/database/app_database.dart';

class OrderModel {
  final int id;
  final List<int> orders;
  final bool isDelivered;
  final int eventID;
  final Guest? guest;
  final Member? member;

  OrderModel({
    required this.id,
    required this.orders,
    required this.isDelivered,
    required this.eventID,
    required this.guest,
    required this.member,
  });
}
