import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

abstract class ITeamSource {
  Future<DataState<List<ResponseTeam>>> getAllTeams();
  Future<DataState<ResponseTeam>> addTeam(TeamParams params);
  Future<DataState<ResponseTeam>> editTeam(TeamParams params);
  Future<DataState<int>> deleteTeam(int id);
}
