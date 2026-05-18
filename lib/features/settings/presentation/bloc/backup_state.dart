part of 'backup_bloc.dart';

sealed class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object> get props => [];
}

final class BackupInitial extends BackupState {}

final class BackupInProgress extends BackupState {}

final class BackupSuccess extends BackupState {}

final class BackupFailure extends BackupState {}
