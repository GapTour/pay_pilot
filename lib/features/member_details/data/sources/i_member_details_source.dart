import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/member_details/data/models/response_member_details.dart';

abstract class IMemberDetailsSource {
  Future<DataState<ResponseMemberDetails>> getMember(int id);
}
