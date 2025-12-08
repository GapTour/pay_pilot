// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final SplashStatus splashStatus;
  final LoginStatus loginStatus;
  const AuthState({required this.splashStatus, required this.loginStatus});

  @override
  List<Object> get props => [splashStatus, loginStatus];

  AuthState copyWith({SplashStatus? splashStatus, LoginStatus? loginStatus}) {
    return AuthState(
      splashStatus: splashStatus ?? this.splashStatus,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
