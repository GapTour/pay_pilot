class TeamMemberParams {
  final int? id;
  final int teamID;
  final int memberID;
  final double ratio;

  TeamMemberParams({
    required this.id,
    required this.teamID,
    required this.memberID,
    required this.ratio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'team_id': teamID,
      'member_id': memberID,
      'ratio_value': ratio,
    };
  }
}
