import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/registering_interceptor.dart';

class LoginApiProvider {
  late final Dio _dio;

  LoginApiProvider() {
    _dio = Dio();
    _dio.interceptors.addAll([
      RegisteringInterceptor(),
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
