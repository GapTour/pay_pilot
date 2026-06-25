import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/data/typedefs/progress_callback.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/settings/data/models/backup_report.dart';
import 'package:pay_pilot/features/settings/data/sources/backup_native_source.dart';
import 'package:pay_pilot/features/settings/data/sources/i_backup_source.dart';
import 'package:share_plus/share_plus.dart';

abstract class IBackupProviderRepository implements IBackupSource {}

class BackupProviderRepository implements IBackupProviderRepository {
  final BackupNativeSource _backupNativeSource;
  late bool isWeb;

  BackupProviderRepository(this._backupNativeSource);

  @override
  Future<DataState<void>> backup() async {
    try {
      return await _backupNativeSource.backup();
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<BackupReport>> restore({
    ProgressCallback? onProgress,
  }) async {
    try {
      return await _backupNativeSource.restore(onProgress: onProgress);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ShareParams>> createNativeBackup() async {
    try {
      return await _backupNativeSource.createNativeBackup();
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<void>> restoreNativeBackup() async {
    try {
      return await _backupNativeSource.restoreNativeBackup();
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
