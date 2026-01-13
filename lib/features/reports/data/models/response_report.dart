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

  factory ResponseReport.fromMap(Map<String, dynamic> map) {
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
}
