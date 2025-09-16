import 'package:pay_pilot/core/database/app_database.dart';

class EventModel {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final Team team;

  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.team,
  });
}
