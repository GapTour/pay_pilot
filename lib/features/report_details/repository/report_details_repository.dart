import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/report_details/data/report_details_db_provider.dart';

class ReportDetailsRepository {
  final ReportDetailsDbProvider _dbProvider;
  ReportDetailsRepository(this._dbProvider);

  Future<Report> getReport(int id) async {
    return await _dbProvider.getReport(id);
  }
}
