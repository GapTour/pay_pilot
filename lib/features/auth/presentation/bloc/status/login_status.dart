part of '../auth_bloc.dart';

sealed class LoginStatus extends Equatable {}

class LoginInit extends LoginStatus {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginStatus {
  @override
  List<Object?> get props => [];
}

class LoginSucceed extends LoginStatus {
  @override
  List<Object?> get props => [];
}

class LoginFailed extends LoginStatus {
  final String message;

  LoginFailed(this.message);
  @override
  List<Object?> get props => [message];
}
