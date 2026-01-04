import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class EventDetailsApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  EventDetailsApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'EventDetailsApiProvider'),
    ]);
  }

  Future<dynamic> addTransaction(TransactionParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.eventTransaction]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editTransaction(TransactionParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.eventTransaction]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteTransaction(int id) async {
    final response = await _dio.delete(
      '${dotenv.env[AppApiUrls.eventTransaction]}$id',
    );

    return response;
  }

  Future<dynamic> addRatio(EventRatioParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.eventRatio]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editRatio(EventRatioParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.eventRatio]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteRatio(int id) async {
    final response = await _dio.delete(
      '${dotenv.env[AppApiUrls.eventRatio]}$id',
    );

    return response;
  }

  Future<dynamic> addOrder(EventOrderParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.eventOrder]}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> editOrder(EventOrderParams params) async {
    final response = await _dio.put(
      '${dotenv.env[AppApiUrls.eventOrder]}${params.id}',
      data: params.toMap(),
    );

    return response;
  }

  Future<dynamic> deleteOrder(int id) async {
    final response = await _dio.delete(
      '${dotenv.env[AppApiUrls.eventOrder]}$id',
    );

    return response;
  }

  Future<dynamic> getEventDetails(int id) async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.event]}$id');

    return response;
  }

  Future<dynamic> getAllMembers() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.member]}');

    return response;
  }

  Future<dynamic> getAllGuests() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.guest]}');

    return response;
  }

  Future<dynamic> getAllMenuItems() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.menu]}');

    return response;
  }
}
