import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';
import 'package:pay_pilot/features/teams/data/sources/i_team_source.dart';
import 'package:pay_pilot/features/teams/data/sources/local_team_source.dart';
import 'package:pay_pilot/features/teams/data/sources/remote_team_source.dart';

abstract class ITeamRepository implements ITeamSource {}

class TeamRepository implements ITeamRepository {
  final LocalTeamSource _localTeamSource;
  final RemoteTeamSource _remoteTeamSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  TeamRepository(
    this._localTeamSource,
    this._remoteTeamSource,
    this._preferencesService,
  );

  @override
  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamSource.getAllTeams();
      return await _remoteTeamSource.getAllTeams();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeam>> addTeam(TeamParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamSource.addTeam(params);
      return await _remoteTeamSource.addTeam(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeam>> editTeam(TeamParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamSource.editTeam(params);
      return await _remoteTeamSource.editTeam(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteTeam(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localTeamSource.deleteTeam(id);
      return await _remoteTeamSource.deleteTeam(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
