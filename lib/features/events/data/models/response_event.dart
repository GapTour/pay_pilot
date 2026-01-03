class ResponseEvent {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final bool isActive;
  final int teamID;

  ResponseEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isActive,
    required this.teamID,
  });

  factory ResponseEvent.fromMap(Map<String, dynamic> map) {
    return ResponseEvent(
      id: int.parse(map['id'] as String),
      teamID: int.parse(map['team_id'] as String),
      title: map['title'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      date: DateTime.parse(map['event_date'] as String),
      isActive: map['is_active'] as String == '1',
    );
  }
}
