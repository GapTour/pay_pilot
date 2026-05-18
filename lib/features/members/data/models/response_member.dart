import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';

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

  factory ResponseMember.fromApi(Map<String, dynamic> map) {
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

  factory ResponseMember.fromDb(Member member) {
    return ResponseMember(
      id: member.id,
      name: member.name,
      description: member.description,
      joinAt: member.joinAt,
      isActive: member.isActive,
      profileImage: member.profileImage,
      birthday: member.birthday,
    );
  }

  factory ResponseMember.fromParams(MemberParams member) {
    return ResponseMember(
      id: member.id!,
      name: member.name,
      description: member.description,
      joinAt: member.joinAt,
      isActive: member.isActive ?? true,
      profileImage: member.profileImage,
      birthday: member.birthday,
    );
  }
}
