import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';

class EventDetailsModel {
  final int id;
  final String title;
  final String? description;
  final List<TransactionModel> transactions;
  final List<MemberRatioModel> memberRatios;
  final List<BalanceModel> membersBalance;
  final DateTime date;
  final Team team;

  EventDetailsModel({
    required this.id,
    required this.title,
    this.description,
    required this.transactions,
    required this.memberRatios,
    required this.date,
    required this.team,
    required this.membersBalance,
  });

  EventDetailsModel copyWith({
    int? id,
    String? title,
    String? description,
    List<TransactionModel>? transactions,
    List<MemberRatioModel>? memberRatios,
    List<BalanceModel>? membersBalance,
    DateTime? date,
    Team? team,
  }) {
    return EventDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      transactions: transactions ?? this.transactions,
      memberRatios: memberRatios ?? this.memberRatios,
      membersBalance: membersBalance ?? this.membersBalance,
      date: date ?? this.date,
      team: team ?? this.team,
    );
  }
}
