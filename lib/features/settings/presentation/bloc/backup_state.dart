part of 'backup_bloc.dart';

class BackupState extends Equatable {
  final ExportStatus exportStatus;
  final ImportStatus importStatus;
  const BackupState({required this.exportStatus, required this.importStatus});

  @override
  List<Object> get props => [exportStatus, importStatus];

  BackupState copyWith({
    ExportStatus? exportStatus,
    ImportStatus? importStatus,
  }) {
    return BackupState(
      exportStatus: exportStatus ?? this.exportStatus,
      importStatus: importStatus ?? this.importStatus,
    );
  }
}
