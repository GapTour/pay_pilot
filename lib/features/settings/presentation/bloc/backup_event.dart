part of 'backup_bloc.dart';

sealed class BackupEvent extends Equatable {
  const BackupEvent();

  @override
  List<Object> get props => [];
}

final class BackupRequested extends BackupEvent {}

final class RestoreRequested extends BackupEvent {}
