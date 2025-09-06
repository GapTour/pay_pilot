import 'package:pay_pilot/core/database/app_database.dart';

class DatabaseService {
  final AppDatabase _db;
  DatabaseService(this._db);

  Future<void> insertIncome(IncomesCompanion income) async {
    await _db.into(_db.incomes).insert(income);
  }

  Future<List<Income>> getAllIncomes() async {
    return await _db.select(_db.incomes).get();
  }

  Future<Income> getIncome(int id) async {
    return (_db.select(
      _db.incomes,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateIncome(IncomesCompanion income) async {
    await _db.update(_db.incomes).replace(income);
  }

  Future<void> deleteIncome(int id) async {
    await (_db.delete(_db.incomes)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> insertMember(MembersCompanion member) async {
    await _db.into(_db.members).insert(member);
  }

  Future<List<Member>> getAllMembers() async {
    return await _db.select(_db.members).get();
  }

  Future<Member> getMember(int id) async {
    return (_db.select(
      _db.members,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateMember(MembersCompanion member) async {
    await _db.update(_db.members).replace(member);
  }

  Future<void> deleteMember(int id) async {
    await (_db.delete(_db.members)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> insertReport(ReportsCompanion report) async {
    await _db.into(_db.reports).insert(report);
  }

  Future<List<Report>> getAllReports() async {
    return await _db.select(_db.reports).get();
  }

  Future<Report> getReport(int id) async {
    return (_db.select(
      _db.reports,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateReport(ReportsCompanion report) async {
    await _db.update(_db.reports).replace(report);
  }

  Future<void> deleteReport(int id) async {
    await (_db.delete(_db.reports)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Future<int> insertTimeEntry(TimeEntriesCompanion timeEntry) async {
  //   return await _db.into(_db.timeEntries).insert(timeEntry);
  // }

  // Future<List<TimeEntry>> getAllTimeEntries({
  //   required int projectId,
  //   required DateTime startDate,
  //   required DateTime endDate,
  // }) async {
  //   final DateTime sDate = DateTime(
  //     startDate.year,
  //     startDate.month,
  //     startDate.day,
  //     0,
  //     0,
  //     0,
  //   );
  //   final DateTime eDate = DateTime(
  //     endDate.year,
  //     endDate.month,
  //     endDate.day,
  //     23,
  //     59,
  //     59,
  //   );

  //   return (_db.select(_db.timeEntries)
  //         ..where((tbl) => tbl.projectId.equals(projectId))
  //         ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
  //         ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //       .get();
  // }

  // Future<List<TimeEntry>> getTimeEntriesForOneDay({
  //   required int projectId,
  //   required DateTime date,
  // }) async {
  //   final DateTime sDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
  //   final DateTime eDate = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     23,
  //     59,
  //     59,
  //   );

  //   return (_db.select(_db.timeEntries)
  //         ..where((tbl) => tbl.projectId.equals(projectId))
  //         ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
  //         ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //       .get();
  // }

  // Future<List<TimeEntry>> getAllProjectsTimeEntriesForOneDay({
  //   required DateTime date,
  // }) async {
  //   final DateTime sDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
  //   final DateTime eDate = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     23,
  //     59,
  //     59,
  //   );

  //   return (_db.select(_db.timeEntries)
  //         ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
  //         ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //       .get();
  // }

  // Future<List<TimeEntry>> getTimeEntriesForSpecificDate({
  //   required DateTime eDate,
  //   required DateTime sDate,
  //   int? projectId,
  // }) async {
  //   if (projectId != null) {
  //     return (_db.select(_db.timeEntries)
  //           ..where(
  //             (tbl) =>
  //                 tbl.startTime.isBetweenValues(
  //                   sDate.copyWith(hour: 0, minute: 0, second: 0),
  //                   eDate.copyWith(hour: 23, minute: 59, second: 59),
  //                 ) &
  //                 tbl.projectId.equals(projectId),
  //           )
  //           ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //         .get();
  //   }
  //   return (_db.select(_db.timeEntries)
  //         ..where(
  //           (tbl) => tbl.startTime.isBetweenValues(
  //             sDate.copyWith(hour: 0, minute: 0, second: 0),
  //             eDate.copyWith(hour: 23, minute: 59, second: 59),
  //           ),
  //         )
  //         ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //       .get();
  // }

  // Future<List<TimeEntry>> getTimeEntriesForOneMonthByProjectID({
  //   required int projectId,
  //   required DateTime sDate,
  //   required DateTime eDate,
  // }) async {
  //   return (_db.select(_db.timeEntries)
  //         ..where((tbl) => tbl.projectId.equals(projectId))
  //         ..where(
  //           (tbl) => tbl.startTime.isBetweenValues(
  //             sDate.copyWith(day: 1, hour: 0, minute: 0, second: 0),
  //             eDate.copyWith(hour: 23, minute: 59, second: 59),
  //           ),
  //         )
  //         ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
  //       .get();
  // }

  // Future<List<TimeEntry>> getAllTimeEntriesByProjectID({
  //   required int projectId,
  // }) async {
  //   return (_db.select(
  //     _db.timeEntries,
  //   )..where((tbl) => tbl.projectId.equals(projectId))).get();
  // }

  // Future<void> updateTimeEntry(Insertable<TimeEntry> timeEntry) async {
  //   await _db.update(_db.timeEntries).replace(timeEntry);
  // }

  // Future<void> updateTimeEntryNew(TimeEntryForm timeEntryForm) async {
  //   await (_db.update(
  //     _db.timeEntries,
  //   )..where((tbl) => tbl.id.isValue(timeEntryForm.id!))).write(
  //     TimeEntriesCompanion(
  //       note: Value(timeEntryForm.description),
  //       startTime: Value(timeEntryForm.startDate),
  //       endTime: Value(timeEntryForm.endDate),
  //       duration: Value(timeEntryForm.duration),
  //     ),
  //   );
  // }

  // Future<void> deleteTimeEntry(int id) async {
  //   await (_db.delete(_db.timeEntries)..where((tbl) => tbl.id.equals(id))).go();
  // }

  // Future<void> deleteDatabase() async {
  //   await _db.close();
  //   final _dbFolder = await getApplicationDocumentsDirectory();
  //   final _dbPath = join(_dbFolder.path, 'your_database_name.sqlite');
  //   final file = File(_dbPath);

  //   if (await file.exists()) {
  //     await file.delete();
  //   }
  // }
}
