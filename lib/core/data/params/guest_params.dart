class GuestParams {
  final int? id;
  final String name;
  final String? description;
  final String? profileImage;
  final bool? isActive;
  final String? telegramID;
  final String? instagramID;
  final String? phone;
  final DateTime? birthday;

  GuestParams({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
    required this.isActive,
    required this.telegramID,
    required this.instagramID,
    required this.phone,
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
      'phone': phone,
      'birthday': birthday?.toIso8601String(),
    };
  }

  GuestParams copyWith({
    int? id,
    String? name,
    String? description,
    String? profileImage,
    bool? isActive,
    String? telegramID,
    String? instagramID,
    String? phone,
    DateTime? birthday,
  }) {
    return GuestParams(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      profileImage: profileImage ?? this.profileImage,
      isActive: isActive ?? this.isActive,
      telegramID: telegramID ?? this.telegramID,
      instagramID: instagramID ?? this.instagramID,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
    );
  }
}
