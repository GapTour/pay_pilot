import 'package:pay_pilot/core/database/app_database.dart';

class ResponseReport {
  final int id;
  final String title;
  final int version;
  final String? description;
  final DateTime generateFor;

  ResponseReport({
    required this.id,
    required this.title,
    required this.version,
    required this.description,
    required this.generateFor,
  });

  factory ResponseReport.fromApi(Map<String, dynamic> map) {
    return ResponseReport(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      version: int.parse(map['version'] as String),
      description: map['description'] != null
          ? map['description'] as String
          : null,
      generateFor: DateTime.parse(map['generated_for'] as String),
    );
  }

  factory ResponseReport.fromDb(Report report) {
    return ResponseReport(
      id: report.id,
      title: report.title,
      version: report.version,
      description: report.description,
      generateFor: report.generateFor,
    );
  }
}
