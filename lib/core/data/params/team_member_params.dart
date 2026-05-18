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

  TeamMemberParams copyWith({
    int? id,
    int? teamID,
    int? memberID,
    double? ratio,
  }) {
    return TeamMemberParams(
      id: id ?? this.id,
      teamID: teamID ?? this.teamID,
      memberID: memberID ?? this.memberID,
      ratio: ratio ?? this.ratio,
    );
  }
}
