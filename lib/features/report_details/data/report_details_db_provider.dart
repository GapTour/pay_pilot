import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/services/db_service.dart';

class ReportDetailsDbProvider {
  final DatabaseService _databaseService;
  ReportDetailsDbProvider(this._databaseService);

  Future<Report> getReport(int id) async {
    return await _databaseService.getReport(id);
  }
}
