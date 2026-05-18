// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:pay_pilot/core/utils/constants/app_settings.dart';
import 'package:pay_pilot/core/utils/logging/log_style.dart';

class AppLogInterceptor extends Interceptor {
  final String apiTitle;
  AppLogInterceptor({required this.apiTitle});

  late String message;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AppSettings.isInterceptorLogEnabled) {
      message =
          'REQUEST $apiTitle\n uri: ${options.uri}\n method: ${options.method}\n extra: ${options.extra}\n data: ${options.data}\n headers: ${options.headers}';
      message.debugLogger;
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (AppSettings.isInterceptorLogEnabled) {
      message =
          'RESPONSE $apiTitle\n uri: ${response.requestOptions.uri}\n statusCode: ${response.statusCode}\n date: ${response.headers['date']}';
      message.testerLogger;
    }

    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (AppSettings.isInterceptorLogEnabled) {
      message =
          'DioException $apiTitle\n uri: ${err.requestOptions.uri}\n statusCode: ${err.response?.statusCode}\n date: ${err.response?.headers['date']}\n error: $err';
      message.warningLogger;
    }

    super.onError(err, handler);
  }
}
