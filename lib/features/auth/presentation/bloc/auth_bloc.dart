import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/enums/splash_type.dart';
import 'package:pay_pilot/core/data/params/login_params.dart';
import 'package:pay_pilot/core/data/params/register_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'status/login_status.dart';
part 'status/register_status.dart';
part 'status/splash_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository)
    : super(
        AuthState(
          splashStatus: SplashInit(),
          loginStatus: LoginInit(),
          registerStatus: RegisterInit(),
        ),
      ) {
    on<CheckAuthStatus>(_checkAuthStatus);
    on<LoginToAccount>(_loginToAccount);
    on<RegisterNewAccount>(_registerNewAccount);
    on<CreateNewPermission>(_createNewPermission);
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

  void _registerNewAccount(
    RegisterNewAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(registerStatus: RegisterLoading()));

    final dataState = await repository.register(event.params);

    if (dataState is DataSuccess) {
      emit(state.copyWith(registerStatus: RegisterSucceed()));
    }

    if (dataState is DataFailed) {
      final errorResponse = dataState.errorResponse!;

      emit(state.copyWith(registerStatus: RegisterFailed(errorResponse.data)));
    }
  }

  void _createNewPermission(
    CreateNewPermission event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(registerStatus: RegisterLoading()));

    final dataState = await repository.createPermission();

    if (dataState is DataSuccess) {
      emit(state.copyWith(registerStatus: RegisterInit()));
    }

    if (dataState is DataFailed) {
      final errorResponse = dataState.errorResponse!;

      emit(state.copyWith(registerStatus: RegisterFailed(errorResponse.data)));
    }
  }
}
