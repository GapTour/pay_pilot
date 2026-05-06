import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';

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

  factory ResponseEvent.fromApi(Map<String, dynamic> map) {
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

  factory ResponseEvent.fromParams(EventParams params) {
    return ResponseEvent(
      id: params.id!,
      title: params.title,
      description: params.description,
      date: params.date,
      isActive: params.isActive ?? true,
      teamID: params.teamID,
    );
  }

  factory ResponseEvent.fromDb(EventModel event) {
    return ResponseEvent(
      id: event.id,
      title: event.title,
      description: event.description,
      date: event.date,
      isActive: event.isActive,
      teamID: event.team.id,
    );
  }
}
