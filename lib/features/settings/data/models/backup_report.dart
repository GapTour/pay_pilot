class TableReport {
  int inserted;
  int updated;
  int skipped;
  final List<String> errors;

  TableReport({
    this.inserted = 0,
    this.updated = 0,
    this.skipped = 0,
    this.errors = const [],
  });
}

class BackupReport {
  final Map<String, TableReport> perTable;
  final List<String> globalErrors;

  BackupReport({required this.perTable, required this.globalErrors});

  int get totalInserted => perTable.values.fold(0, (s, r) => s + r.inserted);
  int get totalUpdated => perTable.values.fold(0, (s, r) => s + r.updated);
  int get totalSkipped => perTable.values.fold(0, (s, r) => s + r.skipped);
}
