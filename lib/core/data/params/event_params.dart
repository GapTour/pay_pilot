class EventParams {
  final int? id;
  final String title;
  final String? description;
  final DateTime date;
  final int teamID;
  final bool? isActive;

  EventParams({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.teamID,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'event_date': date.toIso8601String(),
      'team_id': teamID,
      'is_active': isActive,
    };
  }
}
