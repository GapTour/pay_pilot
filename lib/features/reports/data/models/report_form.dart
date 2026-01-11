import 'package:pay_pilot/core/data/models/event_details_model.dart';

class ReportForm {
  final String title;
  final int version;
  final String? description;
  final DateTime generateFor;
  final List<EventDetailsModel> events;

  ReportForm({
    required this.title,
    required this.version,
    required this.description,
    required this.generateFor,
    required this.events,
  });
}
