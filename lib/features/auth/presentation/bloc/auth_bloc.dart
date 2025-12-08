import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/enums/splash_type.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'status/login_status.dart';
part 'status/splash_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository)
    : super(AuthState(splashStatus: SplashInit(), loginStatus: LoginInit())) {
    on<CheckAuthStatus>(_checkAuthStatus);
    on<LoginToAccount>(_loginToAccount);
  }

  void _checkAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(state.copyWith(splashStatus: SplashLoading()));

    final dataState = await repository.checkAuthStatus();

    if (dataState is DataSuccess) {
      emit(state.copyWith(splashStatus: SplashAuthenticated()));
    }

    if (dataState is DataFailed) {
      final type = SplashType.fromName(dataState.errorResponse?.data);

      if (type.isNeedToUpdate) {
        emit(state.copyWith(splashStatus: SplashNeedUpdate()));
      }
      if (type.isNotAuthenticated) {
        emit(state.copyWith(splashStatus: SplashNotAuthenticated()));
      }
    }
  }

  void _loginToAccount(LoginToAccount event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginStatus: LoginLoading()));

    final dataState = await repository.login(event.params);

    if (dataState is DataSuccess) {
      emit(state.copyWith(loginStatus: LoginSucceed()));
    }

    if (dataState is DataFailed) {
      final errorResponse = dataState.errorResponse!;

      emit(state.copyWith(loginStatus: LoginFailed(errorResponse.data)));
    }
  }
}
