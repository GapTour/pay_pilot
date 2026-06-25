import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/settings/repository/backup_provider_repository.dart';
import 'package:share_plus/share_plus.dart';

part 'backup_event.dart';
part 'backup_state.dart';
part 'status/export_status.dart';
part 'status/import_status.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  final BackupProviderRepository _backupProviderRepository;
  BackupBloc(this._backupProviderRepository)
    : super(
        BackupState(exportStatus: ExportInit(), importStatus: ImportInit()),
      ) {
    on<ChangeToInit>((event, emit) async {
      emit(
        state.copyWith(exportStatus: ExportInit(), importStatus: ImportInit()),
      );
    });
    // on<BackupRequested>((event, emit) async {
    //   emit(BackupInProgress());

    //   final dataState = await _backupProviderRepository.backup();

    //   if (dataState is DataSuccess) {
    //     emit(BackupSuccess(null));
    //   }

    //   if (dataState is DataFailed) {
    //     emit(BackupFailure());
    //   }
    // });
    on<ExportBackupRequested>((event, emit) async {
      emit(state.copyWith(exportStatus: ExportLoading()));

      final dataState = await _backupProviderRepository.createNativeBackup();

      if (dataState is DataSuccess) {
        emit(state.copyWith(exportStatus: ExportFetched(dataState.data!)));
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(exportStatus: ExportFailure(dataState.errorResponse!)),
        );
      }
    });
    // on<RestoreRequested>((event, emit) async {
    //   emit(BackupInProgress());

    //   final dataState = await _backupProviderRepository.restore();

    //   if (dataState is DataSuccess) {
    //     emit(BackupSuccess(null));
    //   }

    //   if (dataState is DataFailed) {
    //     emit(BackupFailure());
    //   }
    // });
    on<ImportBackupRequested>((event, emit) async {
      emit(state.copyWith(importStatus: ImportLoading()));

      final dataState = await _backupProviderRepository.restoreNativeBackup();

      if (dataState is DataSuccess) {
        emit(state.copyWith(importStatus: ImportFetched()));
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(importStatus: ImportFailure(dataState.errorResponse!)),
        );
      }
    });
  }
}
