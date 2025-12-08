import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/enums/splash_type.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/data/response/login_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';
import 'package:pay_pilot/features/auth/data/login_api_provider.dart';

class AuthRepository {
  final LoginApiProvider _loginProvider;
  final SecureStorageService _secureStorageService;

  AuthRepository(this._loginProvider, this._secureStorageService);

  Future<DataState<LoginResponse>> login(LoginParams params) async {
    try {
      final Response response = await _loginProvider.userLogin(params);

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromMap(response.data['data']);

        await _secureStorageService.write(
          AppArguments.accessToken,
          loginResponse.access,
        );
        await _secureStorageService.write(
          AppArguments.refreshToken,
          loginResponse.refresh,
        );
        await _secureStorageService.write(
          AppArguments.expiresIn,
          loginResponse.expiresIn.toString(),
        );

        return DataSuccess(loginResponse);
      }

      return DataFailed(ErrorResponse.defaultError(null));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<void>> checkAuthStatus() async {
    try {
      final expiredIn = await _secureStorageService.read(
        AppArguments.expiresIn,
      );
      if (expiredIn != null) {
        final expiredDate = DateTime.parse(expiredIn);

        if (expiredDate.isBefore(DateTime.now())) {
          return DataFailed(
            ErrorResponse.defaultError(SplashType.needToUpdate.name),
          );
        }

        return DataSuccess(null);
      }

      return DataFailed(
        ErrorResponse.defaultError(SplashType.notAuthenticated.name),
      );
    } catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(SplashType.notAuthenticated.name),
      );
    }
  }
}
