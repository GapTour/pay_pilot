import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';

class ReportDbProvider {
  final ReportDao _databaseService;
  final EventDao _eventDao;
  ReportDbProvider(this._databaseService, this._eventDao);

  Future<List<Report>> getAllReports() async {
    return await _databaseService.getAllReports();
  }

  Future<List<EventDetailsModel>> getAllEvents() async {
    return await _eventDao.getEventsWithoutMembersBalanceAndRatios();
  }

  Future<int> insertReport(ReportForm report) async {
    return await _databaseService.insertReport(report);
  }

  // Future<void> updateReport(ReportForm report) async {
  //   await _databaseService.updateReport(report);
  // }

  Future<void> deleteReport(int report) async {
    await _databaseService.deleteReport(report);
  }
}
