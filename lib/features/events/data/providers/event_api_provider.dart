import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class EventApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  EventApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'EventApiProvider'),
    ]);
  }

  Future<dynamic> addEvent(EventParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.event]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editEvent(EventParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.event]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteEvent(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.event]}$id');

    return response;
  }

  Future<dynamic> getAllEvents() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.event]}');

    return response;
  }

  Future<dynamic> getAllTeams() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.team]}');

    return response;
  }
}
