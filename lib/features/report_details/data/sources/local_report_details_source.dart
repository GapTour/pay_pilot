import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/report_details/data/sources/i_report_details_source.dart';

class LocalReportDetailsSource implements IReportDetailsSource {
  final MemberDao _dbServiceForMember;
  final ReportDao _dbServiceForReport;

  LocalReportDetailsSource(this._dbServiceForMember, this._dbServiceForReport);

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final response = await _dbServiceForMember.getAllMembers();
      final reports = response.map(ResponseMember.fromDb).toList();

      return DataSuccess(reports);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseReportDetails>> getReportDetails(int id) async {
    try {
      final response = await _dbServiceForReport
          .getFullReportDetailsWithoutBalance(id);

      return DataSuccess(response);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
