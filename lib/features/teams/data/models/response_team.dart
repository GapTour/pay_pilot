import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';

class ResponseTeam {
  final int id;
  final String title;
  final String? description;
  final bool isActive;

  ResponseTeam({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });

  factory ResponseTeam.fromApi(Map<String, dynamic> map) {
    return ResponseTeam(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      isActive: map['is_active'] as String == '1',
    );
  }

  factory ResponseTeam.fromDb(Team params) {
    return ResponseTeam(
      id: params.id,
      title: params.title,
      description: params.description,
      isActive: params.isActive ?? true,
    );
  }

  factory ResponseTeam.fromParams(TeamParams params) {
    return ResponseTeam(
      id: params.id!,
      title: params.title,
      description: params.description,
      isActive: params.isActive ?? true,
    );
  }
}
