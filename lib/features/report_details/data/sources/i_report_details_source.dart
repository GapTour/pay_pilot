import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';

abstract class IReportDetailsSource {
  Future<DataState<ResponseReportDetails>> getReportDetails(int id);
  Future<DataState<List<ResponseMember>>> getAllMembers();
}
