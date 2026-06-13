import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_details_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/data/models/response_report.dart';
import 'package:pay_pilot/features/reports/data/sources/i_report_source.dart';

class LocalReportSource implements IReportSource {
  final EventDetailsDao _dbServiceForEvent;
  final ReportDao _dbServiceForReport;

  LocalReportSource(this._dbServiceForEvent, this._dbServiceForReport);

  @override
  Future<DataState<ResponseReport>> createReport(ReportParams params) async {
    try {
      final response = await _dbServiceForReport.insertReport(params);
      final report = ResponseReport.fromDb(response);

      return DataSuccess(report);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteReport(int id) async {
    try {
      await _dbServiceForReport.deleteReport(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseEventDetails>>> getAllEvents() async {
    try {
      final events = await _dbServiceForEvent.getAllEventsInfoWithoutBalance();

      return DataSuccess(events);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseReport>>> getAllReports() async {
    try {
      final response = await _dbServiceForReport.getAllReports();
      final reports = response.map(ResponseReport.fromDb).toList();

      return DataSuccess(reports);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
