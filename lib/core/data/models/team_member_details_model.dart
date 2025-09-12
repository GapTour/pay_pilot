import 'package:pay_pilot/core/database/app_database.dart';

class TeamMemberDetailsModel {
  final int id;
  final double ratio;
  final Member member;
  final Team team;

  TeamMemberDetailsModel({
    required this.id,
    required this.ratio,
    required this.member,
    required this.team,
  });
}
