part of '../auth_bloc.dart';

sealed class RegisterStatus extends Equatable {}

class RegisterInit extends RegisterStatus {
  @override
  List<Object?> get props => [];
}

class RegisterLoading extends RegisterStatus {
  @override
  List<Object?> get props => [];
}

class RegisterSucceed extends RegisterStatus {
  @override
  List<Object?> get props => [];
}

class RegisterFailed extends RegisterStatus {
  final String message;

  RegisterFailed(this.message);
  @override
  List<Object?> get props => [message];
}
