import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class TransactionModel {
  final int id;
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final DateTime date;
  final String? attachment;
  final int? paidByMember;
  final int? paidByGuest;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.date,
    required this.attachment,
    required this.paidByMember,
    required this.paidByGuest,
  });
}
