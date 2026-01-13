import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/data/models/response_report.dart';
import 'package:pay_pilot/features/reports/data/report_api_provider.dart';

class ReportRepository {
  // final ReportDbProvider _dbProvider;
  final ReportApiProvider _apiProvider;
  ReportRepository(
    // this._dbProvider,
    this._apiProvider,
  );

  Future<DataState<List<ResponseReport>>> getAllReports() async {
    try {
      final Response response = await _apiProvider.getAllReports();
      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final reports = rawData.map((e) {
          return ResponseReport.fromMap(e);
        }).toList();

        return DataSuccess(reports);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<List<ResponseEventDetails>>> getAllEvents() async {
    try {
      final Response response = await _apiProvider.getAllEvents();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final events = rawData.map((e) {
          return ResponseEventDetails.fromMap(e);
        }).toList();

        return DataSuccess(events);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseReport>> createReport(ReportParams params) async {
    try {
      final Response response = await _apiProvider.createReport(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final report = ResponseReport.fromMap(rawData);

        return DataSuccess(report);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  // Future<void> updateReport(ReportForm report) async {
  //   await _dbProvider.updateReport(report);
  // }

  Future<DataState<int>> deleteReport(int id) async {
    try {
      final Response response = await _apiProvider.deleteReport(id);
      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
