import 'package:pay_pilot/core/data/enums/transaction_status.dart';

class ResponseEventTransaction {
  final int id;
  final double amount;
  final String? description;
  final DateTime date;
  final TransactionStatus transactionType;
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

  factory ResponseEventTransaction.fromMap(Map<String, dynamic> map) {
    return ResponseEventTransaction(
      id: int.parse(map['id'] as String),
      amount: double.parse(map['amount'] as String),
      description: map['description'] != null
          ? map['description'] as String
          : null,
      date: DateTime.parse(map['transaction_date'] as String),
      transactionType: TransactionStatus.values.firstWhere(
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
}
