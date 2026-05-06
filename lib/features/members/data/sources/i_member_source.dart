import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

abstract class IMemberSource {
  Future<DataState<List<ResponseMember>>> getAllMembers();
  Future<DataState<ResponseMember>> addMember(MemberParams params);
  Future<DataState<ResponseMember>> editMember(MemberParams params);
  Future<DataState<int>> deleteMember(int id);
}
