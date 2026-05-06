import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class MemberApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  MemberApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'MemberApiProvider'),
    ]);
  }

  Future<dynamic> addMember(MemberParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.member]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editMember(MemberParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.member]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteMember(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.member]}$id');

    return response;
  }

  Future<dynamic> getAllMembers() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.member]}');

    return response;
  }
}
