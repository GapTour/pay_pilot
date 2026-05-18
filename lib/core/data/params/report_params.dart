import 'dart:convert';

class ReportParams {
  final String title;
  final String? description;
  final DateTime generateFor;
  final List<int> events;

  ReportParams({
    required this.title,
    required this.description,
    required this.generateFor,
    required this.events,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'generated_for': generateFor.toIso8601String(),
      'events': jsonEncode(events),
    };
  }
}
