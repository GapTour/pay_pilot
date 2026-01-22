class ResponseGuestDetails {
  final int id;
  final String name;
  final String? description;
  final String? telegramID;
  final String? instagramID;
  final String? phone;
  final bool isActive;
  final String? profileImage;
  final DateTime? birthday;

  ResponseGuestDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.telegramID,
    required this.instagramID,
    required this.phone,
    required this.isActive,
    required this.profileImage,
    required this.birthday,
  });

  factory ResponseGuestDetails.fromMap(Map<String, dynamic> map) {
    return ResponseGuestDetails(
      id: int.parse(map['id'] as String),
      name: map['name'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      telegramID: map['telegram_id'] != null
          ? map['telegram_id'] as String
          : null,
      instagramID: map['instagram_id'] != null
          ? map['instagram_id'] as String
          : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
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
