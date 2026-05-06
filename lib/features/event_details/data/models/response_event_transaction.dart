import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class ResponseEventTransaction {
  final int id;
  final double amount;
  final String? description;
  final DateTime date;
  final TransactionType transactionType;
  final String? attachment;
  final int? paidByMember;
  final int? paidByGuest;

  ResponseEventTransaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.transactionType,
    required this.attachment,
    required this.paidByMember,
    required this.paidByGuest,
  });

  factory ResponseEventTransaction.fromApi(Map<String, dynamic> map) {
    return ResponseEventTransaction(
      id: int.parse(map['id'] as String),
      amount: double.parse(map['amount'] as String),
      description: map['description'] != null
          ? map['description'] as String
          : null,
      date: DateTime.parse(map['transaction_date'] as String),
      transactionType: TransactionType.values.firstWhere(
        (type) => type.name == map['transaction_type'],
      ),
      attachment: map['attachment'] != null
          ? map['attachment'] as String
          : null,
      paidByMember: map['member_id'] != null
          ? int.parse(map['member_id'] as String)
          : null,
      paidByGuest: map['guest_id'] != null
          ? int.parse(map['guest_id'] as String)
          : null,
    );
  }

  factory ResponseEventTransaction.fromParams(TransactionParams params) {
    return ResponseEventTransaction(
      id: params.id!,
      amount: params.amount,
      description: params.description,
      date: params.transactionDate,
      transactionType: params.transactionType,
      attachment: params.attachment,
      paidByMember: params.memberID,
      paidByGuest: params.guestID,
    );
  }

  factory ResponseEventTransaction.fromDb(TransactionModel dataModel) {
    return ResponseEventTransaction(
      id: dataModel.id,
      amount: dataModel.amount,
      description: dataModel.description,
      date: dataModel.date,
      transactionType: dataModel.transactionType,
      attachment: dataModel.attachment,
      paidByMember: dataModel.paidByMember,
      paidByGuest: dataModel.paidByGuest,
    );
  }
}
