import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class TeamMemberApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  TeamMemberApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'TeamMemberApiProvider'),
    ]);
  }

  Future<dynamic> addRatio(TeamMemberParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.ratio]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editRatio(TeamMemberParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.ratio]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteRatio(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.ratio]}$id');

    return response;
  }

  Future<dynamic> getAllTeamMembers(int teamID) async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.ratio]}$teamID');

    return response;
  }

  Future<dynamic> getAllMembers() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.member]}');

    return response;
  }

  Future<dynamic> getTeam(int teamID) async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.team]}$teamID');

    return response;
  }
}
