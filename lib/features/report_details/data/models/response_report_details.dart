import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';

class ResponseReportDetails {
  final int id;
  final String title;
  final int version;
  final String? description;
  final DateTime generateFor;
  final List<ResponseEventDetails> events;

  ResponseReportDetails({
    required this.id,
    required this.title,
    required this.version,
    required this.description,
    required this.generateFor,
    required this.events,
  });

  factory ResponseReportDetails.fromApi(Map<String, dynamic> map) {
    final reportMap = map['report'];
    final eventsMap = map['events'] as List<dynamic>;

    return ResponseReportDetails(
      id: int.parse(reportMap['id'] as String),
      title: reportMap['title'] as String,
      version: int.parse(reportMap['version'] as String),
      description: reportMap['description'] != null
          ? reportMap['description'] as String
          : null,
      generateFor: DateTime.parse(reportMap['generated_for'] as String),
      events: eventsMap.map((e) => ResponseEventDetails.fromApi(e)).toList(),
    );
  }
}
