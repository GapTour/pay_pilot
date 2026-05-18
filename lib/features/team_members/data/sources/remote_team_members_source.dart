import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/team_members/data/providers/team_member_api_provider.dart';
import 'package:pay_pilot/features/team_members/data/sources/i_team_members_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class RemoteTeamMembersSource implements ITeamMembersSource {
  final TeamMemberApiProvider _apiProvider;

  RemoteTeamMembersSource(this._apiProvider);

  @override
  Future<DataState<int>> deleteRatio(int ratioID) async {
    try {
      final Response response = await _apiProvider.deleteRatio(ratioID);

      if (response.statusCode == 204) {
        return DataSuccess(ratioID);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

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
  Future<DataState<List<ResponseTeamMember>>> getAllRatios(int teamID) async {
    try {
      final Response response = await _apiProvider.getAllTeamMembers(teamID);

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>?;
        final members =
            rawData?.map((e) {
              return ResponseTeamMember.fromApi(e);
            }).toList() ??
            [];

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseTeam>> getTeamDetails(int teamID) async {
    try {
      final Response response = await _apiProvider.getTeam(teamID);

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as dynamic;
        final team = ResponseTeam.fromApi(rawData);

        return DataSuccess(team);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseTeamMember>> insertRatio(
    TeamMemberParams params,
  ) async {
    try {
      final Response response = await _apiProvider.addRatio(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final teamMember = ResponseTeamMember.fromApi(rawData);

        return DataSuccess(teamMember);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseTeamMember>> updateRatio(
    TeamMemberParams params,
  ) async {
    try {
      final Response response = await _apiProvider.editRatio(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final teamMember = ResponseTeamMember.fromApi(rawData);

        return DataSuccess(teamMember);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
