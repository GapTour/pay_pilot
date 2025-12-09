class TeamParams {
  final int? id;
  final String title;
  final String? description;
  final bool? isActive;

  TeamParams({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'is_active': isActive,
    };
  }
}
