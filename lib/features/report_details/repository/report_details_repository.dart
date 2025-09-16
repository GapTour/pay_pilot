import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/features/report_details/data/report_details_db_provider.dart';

class ReportDetailsRepository {
  final ReportDetailsDbProvider _dbProvider;
  ReportDetailsRepository(this._dbProvider);

  Future<FullReportViewModel> getReport(int id) async {
    return await _dbProvider.getReport(id);
  }
}
