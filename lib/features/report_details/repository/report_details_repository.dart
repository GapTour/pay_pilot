import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/report_details/data/sources/i_report_details_source.dart';
import 'package:pay_pilot/features/report_details/data/sources/local_report_details_source.dart';
import 'package:pay_pilot/features/report_details/data/sources/remote_report_details_source.dart';

abstract class IReportDetailsRepository implements IReportDetailsSource {}

class ReportDetailsRepository implements IReportDetailsRepository {
  final LocalReportDetailsSource _localReportDetailsSource;
  final RemoteReportDetailsSource _remoteReportDetailsSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  ReportDetailsRepository(
    this._localReportDetailsSource,
    this._remoteReportDetailsSource,
    this._preferencesService,
  );

  @override
  Future<DataState<ResponseReportDetails>> getReportDetails(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) {
        return await _localReportDetailsSource.getReportDetails(id);
      }
      return await _remoteReportDetailsSource.getReportDetails(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localReportDetailsSource.getAllMembers();
      return await _remoteReportDetailsSource.getAllMembers();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
