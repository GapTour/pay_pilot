class ResponseTeam {
  final int id;
  final String title;
  final String? description;
  final bool isActive;

  ResponseTeam({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });

  factory ResponseTeam.fromMap(Map<String, dynamic> map) {
    return ResponseTeam(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      isActive: map['is_active'] as String == 'true',
    );
  }
}
