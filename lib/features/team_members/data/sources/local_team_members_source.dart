import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/team_members/data/sources/i_team_members_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class LocalTeamMembersSource implements ITeamMembersSource {
  final RatioDao _dbServiceForRatio;
  final MemberDao _dbServiceForMember;
  LocalTeamMembersSource(this._dbServiceForRatio, this._dbServiceForMember);

  @override
  Future<DataState<int>> deleteRatio(int ratioID) async {
    try {
      await _dbServiceForRatio.deleteRatio(ratioID);

      return DataSuccess(ratioID);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final response = await _dbServiceForMember.getAllMembers();
      final members = response.map(ResponseMember.fromDb).toList();

      return DataSuccess(members);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseTeamMember>>> getAllRatios(int teamID) async {
    try {
      final response = await _dbServiceForRatio.getAllRatios(teamID);
      final ratios = response.map(ResponseTeamMember.fromDb).toList();

      return DataSuccess(ratios);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeam>> getTeamDetails(int teamID) async {
    try {
      final response = await _dbServiceForRatio.getTeam(teamID);
      final team = ResponseTeam.fromDb(response);

      return DataSuccess(team);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeamMember>> insertRatio(
    TeamMemberParams params,
  ) async {
    try {
      final response = await _dbServiceForRatio.insertRatio(params);
      final member = await _dbServiceForMember.getMember(params.memberID);
      final team = ResponseTeamMember.fromParams(
        params.copyWith(id: response),
        member,
      );

      return DataSuccess(team);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeamMember>> updateRatio(
    TeamMemberParams params,
  ) async {
    try {
      await _dbServiceForRatio.updateRatio(params);
      final member = await _dbServiceForMember.getMember(params.memberID);
      final team = ResponseTeamMember.fromParams(params, member);

      return DataSuccess(team);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
