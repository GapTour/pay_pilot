import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/reports/data/report_db_provider.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';

class ReportRepository {
  final ReportDbProvider _dbProvider;
  ReportRepository(this._dbProvider);

  Future<List<Report>> getAllReports() async {
    return await _dbProvider.getAllReports();
  }

  Future<List<EventDetailsModel>> getAllEvents() async {
    return await _dbProvider.getAllEvents();
  }

  Future<int> insertReport(ReportForm report) async {
    return await _dbProvider.insertReport(report);
  }

  // Future<void> updateReport(ReportForm report) async {
  //   await _dbProvider.updateReport(report);
  // }
}
