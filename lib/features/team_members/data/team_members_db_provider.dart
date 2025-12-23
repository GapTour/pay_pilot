import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/features/team_members/data/models/team_members_edit_form.dart';
import 'package:pay_pilot/features/team_members/data/models/team_members_form.dart';

class TeamMembersDbProvider {
  final RatioDao _dbService;
  final TeamDao _teamDao;
  final MemberDao _memberDao;
  TeamMembersDbProvider(this._dbService, this._teamDao, this._memberDao);

  Future<Team> getTeamDetails(int id) async {
    return await _teamDao.getTeam(id);
  }

  Future<List<Member>> getAllMembers() async {
    return await _memberDao.getAllMembers();
  }

  Future<List<TeamMemberDetailsModel>> getAllRatios(int teamID) async {
    return await _dbService.getAllRatios(teamID);
  }

  Future<int> insertRatio(TeamMembersForm ratio) async {
    return await _dbService.insertRatio(ratio);
  }

  Future<void> updateRatio(TeamMembersEditForm ratio) async {
    await _dbService.updateRatio(ratio);
  }

  Future<void> deleteRatio(int ratio) async {
    await _dbService.deleteRatio(ratio);
  }
}
