import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/data/models/response_report.dart';
import 'package:pay_pilot/features/reports/data/sources/i_report_source.dart';
import 'package:pay_pilot/features/reports/data/sources/local_report_source.dart';
import 'package:pay_pilot/features/reports/data/sources/remote_report_source.dart';

abstract class IReportRepository implements IReportSource {}

class ReportRepository implements IReportRepository {
  final RemoteReportSource _remoteReportSource;
  final LocalReportSource _localReportSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  ReportRepository(
    this._remoteReportSource,
    this._localReportSource,
    this._preferencesService,
  );

  @override
  Future<DataState<List<ResponseReport>>> getAllReports() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localReportSource.getAllReports();
      return await _remoteReportSource.getAllReports();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseEventDetails>>> getAllEvents() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localReportSource.getAllEvents();
      return await _remoteReportSource.getAllEvents();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseReport>> createReport(ReportParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localReportSource.createReport(params);
      return await _remoteReportSource.createReport(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteReport(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localReportSource.deleteReport(id);
      return await _remoteReportSource.deleteReport(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
