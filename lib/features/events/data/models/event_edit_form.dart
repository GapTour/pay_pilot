class EventEditForm {
  final int id;
  final String title;
  final String? description;
  final int teamID;
  final DateTime date;

  EventEditForm({
    required this.id,
    required this.title,
    required this.date,
    required this.teamID,
    required this.description,
  });
}
