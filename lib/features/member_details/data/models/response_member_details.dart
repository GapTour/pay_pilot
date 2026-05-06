import 'package:pay_pilot/core/database/app_database.dart';

class ResponseMemberDetails {
  final int id;
  final String name;
  final String? description;
  final DateTime? joinAt;
  final bool isActive;
  final String? profileImage;
  final DateTime? birthday;

  ResponseMemberDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.joinAt,
    required this.isActive,
    required this.profileImage,
    required this.birthday,
  });

  factory ResponseMemberDetails.fromApi(Map<String, dynamic> map) {
    return ResponseMemberDetails(
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

  factory ResponseMemberDetails.fromDb(Member member) {
    return ResponseMemberDetails(
      id: member.id,
      name: member.name,
      description: member.description,
      joinAt: member.joinAt,
      isActive: member.isActive ?? true,
      profileImage: member.profileImage,
      birthday: member.birthday,
    );
  }
}
