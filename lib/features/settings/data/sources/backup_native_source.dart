import 'package:cross_file/cross_file.dart' as xfile;
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/data/typedefs/progress_callback.dart';
import 'package:pay_pilot/core/database/daos/settings_dao/settings_dao.dart';
import 'package:pay_pilot/core/utils/helpers/pick_file_helper.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/settings/data/models/backup_report.dart';
import 'package:pay_pilot/features/settings/data/sources/i_backup_source.dart';
import 'package:share_plus/share_plus.dart';

class BackupNativeSource implements IBackupSource {
  final SettingsDao _settingsDao;
  BackupNativeSource(this._settingsDao);

  @override
  Future<DataState<void>> backup() async {
    try {
      final bytes = await _settingsDao.exportBackup();
      final filename = 'backup_${DateTime.now().toIso8601String()}.json';

      final params = ShareParams(
        title: 'Share Backup File',
        files: [xfile.XFile.fromData(bytes)],
        fileNameOverrides: [filename],
      );

      final result = await SharePlus.instance.share(params);

      if (result.status == ShareResultStatus.success) {
        return DataSuccess(null);
      }

      return DataFailed(
        ErrorResponse.defaultError('Share operation was not successful', null),
      );
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
    final dataState = await PickFileHelper.pickJsonFile();

    if (dataState is DataFailed) {
      return DataFailed(dataState.errorResponse);
    }

    final backupReport = await _settingsDao.importBackup(
      dataState.data!,
      onProgress: onProgress,
    );

    return DataSuccess(backupReport);
  }
}
