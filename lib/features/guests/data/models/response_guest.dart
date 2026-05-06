import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';

class ResponseGuest {
  final int id;
  final String name;
  final String? description;
  final String? telegramID;
  final String? instagramID;
  final String? phone;
  final bool isActive;
  final String? profileImage;
  final DateTime? birthday;

  ResponseGuest({
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

  factory ResponseGuest.fromApi(Map<String, dynamic> map) {
    return ResponseGuest(
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

  factory ResponseGuest.fromDb(Guest guest) {
    return ResponseGuest(
      id: guest.id,
      name: guest.name,
      description: guest.description,
      telegramID: guest.telegramId,
      instagramID: guest.instagramId,
      phone: guest.phoneNumber,
      isActive: guest.isActive ?? true,
      profileImage: guest.profileImage,
      birthday: guest.birthday,
    );
  }

  factory ResponseGuest.fromParams(GuestParams guest) {
    return ResponseGuest(
      id: guest.id!,
      name: guest.name,
      description: guest.description,
      telegramID: guest.telegramID,
      instagramID: guest.instagramID,
      phone: guest.phone,
      isActive: guest.isActive ?? true,
      profileImage: guest.profileImage,
      birthday: guest.birthday,
    );
  }
}
