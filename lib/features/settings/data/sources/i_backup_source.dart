import 'package:pay_pilot/core/data/typedefs/progress_callback.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/settings/data/models/backup_report.dart';
import 'package:share_plus/share_plus.dart';

abstract class IBackupSource {
  Future<DataState<void>> backup();
  Future<DataState<BackupReport>> restore({ProgressCallback? onProgress});
  Future<DataState<ShareParams>> createNativeBackup();
  Future<DataState<void>> restoreNativeBackup();
}
