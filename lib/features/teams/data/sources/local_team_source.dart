import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';
import 'package:pay_pilot/features/teams/data/sources/i_team_source.dart';

class LocalTeamSource implements ITeamSource {
  final TeamDao _dbService;

  LocalTeamSource(this._dbService);

  @override
  Future<DataState<ResponseTeam>> addTeam(TeamParams params) async {
    try {
      final response = await _dbService.insertTeam(params);
      final team = ResponseTeam.fromParams(params.copyWith(id: response));

      return DataSuccess(team);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteTeam(int id) async {
    try {
      await _dbService.archiveTeam(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseTeam>> editTeam(TeamParams params) async {
    try {
      await _dbService.updateTeam(params);
      final team = ResponseTeam.fromParams(params);

      return DataSuccess(team);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      final response = await _dbService.getAllTeams();
      final members = response.map(ResponseTeam.fromDb).toList();

      return DataSuccess(members);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
