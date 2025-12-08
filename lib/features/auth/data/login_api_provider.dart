import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class LoginApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  LoginApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'LoginApiProvider'),
    ]);
  }

  Future<dynamic> userLogin(LoginParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.login]}',
      data: params.toMap(),
    );

    return response;
  }
}
