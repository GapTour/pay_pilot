// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class RemoveModeStatus extends AuthEvent {}

class SetModeStatus extends AuthEvent {
  final bool isOffline;

  const SetModeStatus(this.isOffline);
}

class CreateNewPermission extends AuthEvent {}

class LoginToAccount extends AuthEvent {
  final LoginParams params;

  const LoginToAccount(this.params);
}

class RegisterNewAccount extends AuthEvent {
  final RegisterParams params;

  const RegisterNewAccount(this.params);
}
