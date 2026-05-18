import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class TransactionParams {
  final int? id;
  final double amount;
  final String? description;
  final DateTime transactionDate;
  final TransactionType transactionType;
  final String? attachment;
  final int eventID;
  final int? memberID;
  final int? guestID;
  final bool hasPermissionDeleteOrder;

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
    required this.hasPermissionDeleteOrder,
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

  TransactionParams copyWith({
    int? id,
    double? amount,
    String? description,
    DateTime? transactionDate,
    TransactionType? transactionType,
    String? attachment,
    int? eventID,
    int? memberID,
    int? guestID,
    bool? hasPermissionDeleteOrder,
  }) {
    return TransactionParams(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      transactionType: transactionType ?? this.transactionType,
      attachment: attachment ?? this.attachment,
      eventID: eventID ?? this.eventID,
      memberID: memberID ?? this.memberID,
      guestID: guestID ?? this.guestID,
      hasPermissionDeleteOrder:
          hasPermissionDeleteOrder ?? this.hasPermissionDeleteOrder,
    );
  }
}
