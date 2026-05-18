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

  MemberParams copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? joinAt,
    bool? isActive,
    String? profileImage,
    DateTime? birthday,
  }) {
    return MemberParams(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      joinAt: joinAt ?? this.joinAt,
      isActive: isActive ?? this.isActive,
      profileImage: profileImage ?? this.profileImage,
      birthday: birthday ?? this.birthday,
    );
  }
}
