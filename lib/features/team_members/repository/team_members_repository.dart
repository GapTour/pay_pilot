import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/team_members/data/team_members_db_provider.dart';
import 'package:pay_pilot/features/team_members/data/team_members_edit_form.dart';
import 'package:pay_pilot/features/team_members/data/team_members_form.dart';

class TeamMembersRepository {
  final TeamMembersDbProvider _dbProvider;
  TeamMembersRepository(this._dbProvider);

  Future<Team> getTeamDetails(int id) async {
    return await _dbProvider.getTeamDetails(id);
  }

  Future<List<Member>> getAllMembers() async {
    return await _dbProvider.getAllMembers();
  }

  Future<List<TeamMemberDetailsModel>> getAllRatios(int teamID) async {
    return await _dbProvider.getAllRatios(teamID);
  }

  Future<int> insertRatio(TeamMembersForm ratio) async {
    return await _dbProvider.insertRatio(ratio);
  }

  Future<void> updateRatio(TeamMembersEditForm ratio) async {
    await _dbProvider.updateRatio(ratio);
  }

  Future<void> deleteRatio(int ratio) async {
    await _dbProvider.deleteRatio(ratio);
  }
}
