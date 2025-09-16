import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';

class ReportDetailsDbProvider {
  final ReportDao _databaseService;
  ReportDetailsDbProvider(this._databaseService);

  Future<FullReportViewModel> getReport(int id) async {
    return await _databaseService.getFullReportDetails(id);
  }
}
