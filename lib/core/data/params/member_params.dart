class MemberParams {
  final int? id;
  final String name;
  final String? description;
  final DateTime? joinAt;
  final bool? isActive;
  final String? profileImage;
  final DateTime? birthday;

  MemberParams({
    required this.id,
    required this.name,
    required this.description,
    required this.joinAt,
    required this.isActive,
    required this.profileImage,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'joined_at': joinAt?.toIso8601String(),
      'is_active': isActive,
      'profile_image': profileImage,
      'birthday': birthday?.toIso8601String(),
    };
  }
}
