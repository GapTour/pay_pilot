import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/features/teams/data/team_edit_form.dart';
import 'package:pay_pilot/features/teams/data/team_form.dart';

class TeamsDbProvider {
  final TeamDao _dbService;
  TeamsDbProvider(this._dbService);

  Future<List<Team>> getAllTeams() async {
    return await _dbService.getAllTeams();
  }

  Future<int> insertTeam(TeamForm team) async {
    return await _dbService.insertTeam(team);
  }

  Future<void> updateTeam(TeamEditForm team) async {
    await _dbService.updateTeam(team);
  }

  Future<void> deleteTeam(int teamID) async {
    await _dbService.deleteTeam(teamID);
  }
}
