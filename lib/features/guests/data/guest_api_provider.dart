import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class GuestApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  GuestApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'GuestApiProvider'),
    ]);
  }

  Future<dynamic> addGuest(GuestParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.guest]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editGuest(GuestParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.guest]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteGuest(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.guest]}$id');

    return response;
  }

  Future<dynamic> getAllGuests() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.guest]}');

    return response;
  }
}
