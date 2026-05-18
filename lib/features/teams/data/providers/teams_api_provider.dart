import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class TeamsApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  TeamsApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'TeamsApiProvider'),
    ]);
  }

  Future<dynamic> addTeam(TeamParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.team]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editTeam(TeamParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.team]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteTeam(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.team]}$id');

    return response;
  }

  Future<dynamic> getAllTeams() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.team]}');

    return response;
  }
}
