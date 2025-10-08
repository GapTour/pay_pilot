import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class TransactionModel {
  final int id;
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.date,
  });
}
