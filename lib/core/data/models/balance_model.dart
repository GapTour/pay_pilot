import 'package:pay_pilot/core/database/app_database.dart';

class BalanceModel {
  final Member member;
  final double totalBalance;

  BalanceModel({required this.member, required this.totalBalance});
}
