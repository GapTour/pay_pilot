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

  EventParams copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    int? teamID,
    bool? isActive,
  }) {
    return EventParams(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      teamID: teamID ?? this.teamID,
      isActive: isActive ?? this.isActive,
    );
  }
}
