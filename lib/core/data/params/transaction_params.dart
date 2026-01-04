import 'package:pay_pilot/core/data/enums/transaction_status.dart';

class TransactionParams {
  final int? id;
  final double amount;
  final String? description;
  final DateTime transactionDate;
  final TransactionStatus transactionType;
  final String? attachment;
  final int eventID;
  final int? memberID;
  final int? guestID;

  TransactionParams({
    required this.id,
    required this.amount,
    required this.description,
    required this.transactionDate,
    required this.transactionType,
    required this.attachment,
    required this.eventID,
    required this.memberID,
    required this.guestID,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'transaction_date': transactionDate.toIso8601String(),
      'transaction_type': transactionType.name,
      'attachment': attachment,
      'event_id': eventID,
      'member_id': memberID,
      'guest_id': guestID,
    };
  }
}
