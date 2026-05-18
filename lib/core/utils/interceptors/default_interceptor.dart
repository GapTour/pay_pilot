import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_pilot/core/utils/constants/app_api_urls.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';

class DefaultInterceptor extends Interceptor {
  final SecureStorageService secureStorage;
  DefaultInterceptor(this.secureStorage);

  bool retryingGetNewToken = false;
  bool retryingLastRequest = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options
      ..baseUrl = dotenv.env[AppApiUrls.baseUrl]!
      ..maxRedirects = 1;

    // await HelperInterceptor.onCustomRequest(
    //   secureStorage: secureStorage,
    //   onChangeRetryingGetNewTokenTo: (value) => retryingGetNewToken = value,
    //   onUpdateOptions: (accessToken) {
    //     options.headers['Authorization'] = 'Bearer $accessToken';
    //     if (retryingGetNewToken) {
    //       handler.next(options);
    //     }
    //   },
    //   authRepository: locator(),
    // );

    String? accessToken = await secureStorage.read(AppArguments.accessToken);
    options.headers['Authorization'] = 'Bearer $accessToken';
    if (!retryingGetNewToken) super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // await HelperInterceptor.onCustomError(
    //   err,
    //   handler,
    //   retryingLastRequest: retryingLastRequest,
    //   onChangeRetryingLastRequestTo: (value) {
    //     retryingLastRequest = value;
    //   },
    //   authRepository: locator(),
    // );
    if (!retryingLastRequest) super.onError(err, handler);
  }
}
