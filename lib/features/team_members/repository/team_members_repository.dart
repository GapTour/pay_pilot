import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/team_members/data/sources/i_team_members_source.dart';
import 'package:pay_pilot/features/team_members/data/sources/local_team_members_source.dart';
import 'package:pay_pilot/features/team_members/data/sources/remote_team_members_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

abstract class ITeamMembersRepository implements ITeamMembersSource {}

class TeamMembersRepository implements ITeamMembersRepository {
  final LocalTeamMembersSource _localTeamMembersSource;
  final RemoteTeamMembersSource _remoteTeamMembersSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  TeamMembersRepository(
    this._localTeamMembersSource,
    this._remoteTeamMembersSource,
    this._preferencesService,
  );

  @override
  Future<DataState<ResponseTeam>> getTeamDetails(int teamID) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) {
        return await _localTeamMembersSource.getTeamDetails(teamID);
      }
      return await _remoteTeamMembersSource.getTeamDetails(teamID);
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
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamMembersSource.getAllMembers();
      return await _remoteTeamMembersSource.getAllMembers();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseTeamMember>>> getAllRatios(int teamID) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamMembersSource.getAllRatios(teamID);
      return await _remoteTeamMembersSource.getAllRatios(teamID);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
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
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamMembersSource.insertRatio(params);
      return await _remoteTeamMembersSource.insertRatio(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
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
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamMembersSource.updateRatio(params);
      return await _remoteTeamMembersSource.updateRatio(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteRatio(int ratioID) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamMembersSource.deleteRatio(ratioID);
      return await _remoteTeamMembersSource.deleteRatio(ratioID);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
