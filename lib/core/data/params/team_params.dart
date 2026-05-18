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

  TeamParams copyWith({
    int? id,
    String? title,
    String? description,
    bool? isActive,
  }) {
    return TeamParams(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
