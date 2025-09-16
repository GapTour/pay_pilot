import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class TransactionForm {
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final int eventID;
  final DateTime date;

  TransactionForm({
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.eventID,
    required this.date,
  });
}
