import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/services/db_service.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';

class ReportDbProvider {
  final DatabaseService _databaseService;
  ReportDbProvider(this._databaseService);

  Future<List<Report>> getAllReports() async {
    return await _databaseService.getAllReports();
  }

  Future<int> insertReport(ReportForm report) async {
    return await _databaseService.insertReport(report);
  }

  Future<void> updateReport(ReportForm report) async {
    await _databaseService.updateReport(report);
  }
}
