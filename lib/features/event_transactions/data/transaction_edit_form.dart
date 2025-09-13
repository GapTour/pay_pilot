import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class TransactionEditForm {
  final int id;
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final int eventID;
  final DateTime date;

  TransactionEditForm({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.eventID,
    required this.date,
  });
}
