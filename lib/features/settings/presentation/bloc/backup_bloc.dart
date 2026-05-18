import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/settings/repository/backup_provider_repository.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final BackupProviderRepository _backupProviderRepository;
  BackupBloc(this._backupProviderRepository) : super(BackupInitial()) {
    on<BackupRequested>((event, emit) async {
      emit(BackupInProgress());

      final dataState = await _backupProviderRepository.backup();

      if (dataState is DataSuccess) {
        emit(BackupSuccess());
      }

      if (dataState is DataFailed) {
        emit(BackupFailure());
      }
    });
    on<RestoreRequested>((event, emit) async {
      emit(BackupInProgress());

      final dataState = await _backupProviderRepository.restore();

      if (dataState is DataSuccess) {
        emit(BackupSuccess());
      }

      if (dataState is DataFailed) {
        emit(BackupFailure());
      }
    });
  }
}
