part of '../backup_bloc.dart';

sealed class ImportStatus extends Equatable {}

class ImportInit extends ImportStatus {
  @override
  List<Object?> get props => [];
}

class ImportLoading extends ImportStatus {
  @override
  List<Object?> get props => [];
}

class ImportFetched extends ImportStatus {
  @override
  List<Object?> get props => [];
}

class ImportFailure extends ImportStatus {
  final ErrorResponse error;

  ImportFailure(this.error);
  @override
  List<Object?> get props => [error];
}
