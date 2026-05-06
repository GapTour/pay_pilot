import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

abstract class ITeamMembersSource {
  Future<DataState<ResponseTeam>> getTeamDetails(int teamID);
  Future<DataState<List<ResponseMember>>> getAllMembers();
  Future<DataState<List<ResponseTeamMember>>> getAllRatios(int teamID);
  Future<DataState<ResponseTeamMember>> insertRatio(TeamMemberParams params);
  Future<DataState<ResponseTeamMember>> updateRatio(TeamMemberParams params);
  Future<DataState<int>> deleteRatio(int ratioID);
}
