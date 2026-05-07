import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/report_details/data/providers/report_details_api_provider.dart';
import 'package:pay_pilot/features/report_details/data/sources/i_report_details_source.dart';

class RemoteReportDetailsSource implements IReportDetailsSource {
  final ReportDetailsApiProvider _apiProvider;
  RemoteReportDetailsSource(this._apiProvider);

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final Response response = await _apiProvider.getAllMembers();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseMember.fromApi(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseReportDetails>> getReportDetails(int id) async {
    try {
      final Response response = await _apiProvider.getReportDetails(id);

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as dynamic;
        final report = ResponseReportDetails.fromApi(rawData);

        return DataSuccess(report);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
