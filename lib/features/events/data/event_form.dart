class EventForm {
  final String title;
  final String? description;
  final int teamID;
  final DateTime date;

  EventForm({
    required this.title,
    required this.date,
    required this.teamID,
    required this.description,
  });
}
