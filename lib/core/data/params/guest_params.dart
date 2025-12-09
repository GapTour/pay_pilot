class GuestParams {
  final int? id;
  final String name;
  final String? description;
  final String? profileImage;
  final bool? isActive;
  final String? telegramID;
  final String? instagramID;
  final DateTime? birthday;

  GuestParams({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
    required this.isActive,
    required this.telegramID,
    required this.instagramID,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'profile_image': profileImage,
      'is_active': isActive,
      'telegram_id': telegramID,
      'instagram_id': instagramID,
      'birthday': birthday?.toIso8601String(),
    };
  }
}
