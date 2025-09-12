import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class EventDetailsModel {
  final int id;
  final String title;
  final String? description;
  final List<Transactions> transactions;
  final DateTime date;
  final Team team;

  EventDetailsModel({
    required this.id,
    required this.title,
    this.description,
    required this.transactions,
    required this.date,
    required this.team,
  });

  EventDetailsModel copyWith({
    int? id,
    String? title,
    String? description,
    List<Transactions>? transactions,
    DateTime? date,
    Team? team,
  }) {
    return EventDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      transactions: transactions ?? this.transactions,
      date: date ?? this.date,
      team: team ?? this.team,
    );
  }
}

class Transactions {
  final int id;
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final DateTime date;

  Transactions({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.date,
  });
}
