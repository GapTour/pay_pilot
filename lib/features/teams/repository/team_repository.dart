import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/teams/data/team_edit_form.dart';
import 'package:pay_pilot/features/teams/data/team_form.dart';
import 'package:pay_pilot/features/teams/data/teams_db_provider.dart';

class TeamRepository {
  final TeamsDbProvider _dbProvider;
  TeamRepository(this._dbProvider);

  Future<List<Team>> getAllTeams() async {
    return await _dbProvider.getAllTeams();
  }

  Future<int> insertTeam(TeamForm team) async {
    return await _dbProvider.insertTeam(team);
  }

  Future<void> updateTeam(TeamEditForm team) async {
    await _dbProvider.updateTeam(team);
  }
}
