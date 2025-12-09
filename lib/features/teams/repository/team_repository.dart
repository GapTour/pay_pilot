import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';
import 'package:pay_pilot/features/teams/data/teams_api_provider.dart';

class TeamRepository {
  // final TeamsDbProvider _dbProvider;
  final TeamsApiProvider _apiProvider;
  TeamRepository(
    // this._dbProvider
    this._apiProvider,
  );

  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      final Response response = await _apiProvider.getAllTeams();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final teams = rawData.map((e) {
          return ResponseTeam.fromMap(e);
        }).toList();

        return DataSuccess(teams);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseTeam>> addTeam(TeamParams params) async {
    try {
      final Response response = await _apiProvider.addTeam(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final team = ResponseTeam.fromMap(rawData);

        return DataSuccess(team);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseTeam>> editTeam(TeamParams params) async {
    try {
      final Response response = await _apiProvider.editTeam(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseTeam.fromMap(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<int>> deleteTeam(int id) async {
    try {
      final Response response = await _apiProvider.deleteTeam(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
