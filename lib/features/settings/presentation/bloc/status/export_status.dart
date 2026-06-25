part of '../backup_bloc.dart';

sealed class ExportStatus extends Equatable {}

class ExportInit extends ExportStatus {
  @override
  List<Object?> get props => [];
}

class ExportLoading extends ExportStatus {
  @override
  List<Object?> get props => [];
}

class ExportFetched extends ExportStatus {
  final ShareParams params;

  ExportFetched(this.params);
  @override
  List<Object?> get props => [params];
}

class ExportFailure extends ExportStatus {
  final ErrorResponse error;

  ExportFailure(this.error);
  @override
  List<Object?> get props => [error];
}
