import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/interceptors/app_log_interceptor.dart';
import 'package:pay_pilot/core/utils/interceptors/default_interceptor.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class ReportDetailsApiProvider {
  final SecureStorageService secureStorage;
  late final Dio _dio;

  ReportDetailsApiProvider(this.secureStorage) {
    _dio = Dio();
    _dio.interceptors.addAll([
      DefaultInterceptor(secureStorage),
      AppLogInterceptor(apiTitle: 'ReportDetailsApiProvider'),
    ]);
  }

  Future<dynamic> getReportDetails(int id) async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.report]}$id');

    return response;
  }

  Future<dynamic> getAllMembers() async {
    final response = await _dio.get('${dotenv.env[AppApiUrls.member]}');

    return response;
  }
}
