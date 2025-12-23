import 'package:pay_pilot/features/members/data/models/response_member.dart';

class ResponseTeamMember {
  final int id;
  final ResponseMember memberInfo;
  final double ratio;

  ResponseTeamMember({
    required this.id,
    required this.memberInfo,
    required this.ratio,
  });

  factory ResponseTeamMember.fromMap(Map<String, dynamic> map) {
    return ResponseTeamMember(
      id: int.parse(map['id'] as String),
      memberInfo: ResponseMember.fromMap(map['member'] as Map<String, dynamic>),
      ratio: double.parse(map['ratio_value'] as String),
    );
  }
}
