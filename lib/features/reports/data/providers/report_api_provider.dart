import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class ReportApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  ReportApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'ReportApiProvider'),
    ]);
  }

  Future<dynamic> createReport(ReportParams params) async {
    final response = await _dio.post(
      '${dotenv.env[AppApiUrls.report]}',
      data: params.toMap(),
    );

    return response;
  }

  // Future<dynamic> editMember(MemberParams params) async {
  //   final response = await _dio.put(
  //     '${dotenv.env[AppApiUrls.member]}${params.id}',
  //     data: params.toMap(),
  //   );

  //   return response;
  // }

  Future<dynamic> deleteReport(int id) async {
    final response = await _dio.delete('${dotenv.env[AppApiUrls.report]}$id');

    return response;
  }

  Future<dynamic> getAllReports() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.report]}');

    return response;
  }

  Future<dynamic> getAllEvents() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.event]}');

    return response;
  }
}
