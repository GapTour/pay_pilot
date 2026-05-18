// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final SplashStatus splashStatus;
  final LoginStatus loginStatus;
  final RegisterStatus registerStatus;
  const AuthState({
    required this.splashStatus,
    required this.loginStatus,
    required this.registerStatus,
  });

  @override
  List<Object> get props => [splashStatus, loginStatus, registerStatus];

  AuthState copyWith({
    SplashStatus? splashStatus,
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
  }) {
    return AuthState(
      splashStatus: splashStatus ?? this.splashStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }
}
