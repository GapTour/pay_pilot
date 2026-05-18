import 'package:pay_pilot/features/members/data/models/response_member.dart';

class ResponseEventBalance {
  final double salary;
  final double? expenses;
  final ResponseMember member;

  ResponseEventBalance({
    required this.salary,
    required this.expenses,
    required this.member,
  });

  ResponseEventBalance copyWith({
    double? salary,
    double? expenses,
    ResponseMember? member,
  }) {
    return ResponseEventBalance(
      salary: salary ?? this.salary,
      expenses: expenses ?? this.expenses,
      member: member ?? this.member,
    );
  }
}
