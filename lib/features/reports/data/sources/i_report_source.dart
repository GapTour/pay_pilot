import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/data/models/response_report.dart';

abstract class IReportSource {
  Future<DataState<List<ResponseReport>>> getAllReports();
  Future<DataState<List<ResponseEventDetails>>> getAllEvents();
  Future<DataState<ResponseReport>> createReport(ReportParams params);
  Future<DataState<int>> deleteReport(int id);
}
