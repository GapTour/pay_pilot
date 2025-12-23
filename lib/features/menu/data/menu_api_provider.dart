import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class MenuApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  MenuApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'MenuApiProvider'),
    ]);
  }

  Future<dynamic> addMenuItem(MenuParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.menu]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editMenuItem(MenuParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.menu]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteMenuItem(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.menu]}$id');

    return response;
  }

  Future<dynamic> getAllItems() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.menu]}');

    return response;
  }
}
