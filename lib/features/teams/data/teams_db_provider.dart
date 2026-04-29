import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';

class TeamsDbProvider {
  final TeamDao _dbService;
  TeamsDbProvider(this._dbService);

  Future<List<Team>> getAllTeams() async {
    return await _dbService.getAllTeams();
  }

  Future<int> insertTeam(TeamParams team) async {
    return await _dbService.insertTeam(team);
  }

  Future<void> updateTeam(TeamParams team) async {
    await _dbService.updateTeam(team);
  }

  Future<void> deleteTeam(int teamID) async {
    await _dbService.deleteTeam(teamID);
  }
}
