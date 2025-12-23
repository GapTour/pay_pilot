class ResponseMember {
  final int id;
  final String name;
  final String? description;
  final DateTime? joinAt;
  final bool isActive;
  final String? profileImage;
  final DateTime? birthday;

  ResponseMember({
    required this.id,
    required this.name,
    required this.description,
    required this.joinAt,
    required this.isActive,
    required this.profileImage,
    required this.birthday,
  });

  factory ResponseMember.fromMap(Map<String, dynamic> map) {
    return ResponseMember(
      id: int.parse(map['id'] as String),
      name: map['name'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      joinAt: map['joined_at'] != null
          ? DateTime.parse(map['joined_at'] as String)
          : null,
      isActive: map['is_active'] as String == '1',
      profileImage: map['profile_image'] != null
          ? map['profile_image'] as String
          : null,
      birthday: map['birthday'] != null
          ? DateTime.parse(map['birthday'] as String)
          : null,
    );
  }
}
