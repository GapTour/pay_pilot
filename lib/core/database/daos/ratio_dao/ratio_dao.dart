import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/features/team_members/data/team_members_edit_form.dart';
import 'package:pay_pilot/features/team_members/data/team_members_form.dart';

part 'ratio_dao.g.dart';

@DriftAccessor(tables: [Ratios, Members, Teams])
class RatioDao extends DatabaseAccessor<AppDatabase> with _$RatioDaoMixin {
  RatioDao(super.db);

  Future<Team> getTeam(int id) async {
    return (db.select(db.teams)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> insertRatio(TeamMembersForm teamMember) async {
    return await db
        .into(db.ratios)
        .insert(
          RatiosCompanion(
            ratio: Value(teamMember.ratio),
            memberID: Value(teamMember.memberID),
            teamID: Value(teamMember.teamID),
          ),
        );
  }

  Future<List<TeamMemberDetailsModel>> getAllRatios(int teamID) async {
    final query = (select(ratios)..where((tbl) => tbl.teamID.equals(teamID)))
        .join([
          innerJoin(members, members.id.equalsExp(ratios.memberID)),
          innerJoin(teams, teams.id.equalsExp(ratios.teamID)),
        ]);

    final rows = await query.get();

    return rows.map((row) {
      return TeamMemberDetailsModel(
        id: row.readTable(ratios).id,
        ratio: row.readTable(ratios).ratio,
        member: row.readTable(members),
        team: row.readTable(teams),
      );
    }).toList();
  }

  Future<TeamMemberDetailsModel> getRatio(int id) async {
    final query = (select(ratios)..where((tbl) => tbl.id.equals(id))).join([
      innerJoin(members, members.id.equalsExp(ratios.memberID)),
      innerJoin(teams, teams.id.equalsExp(ratios.teamID)),
    ]);

    final row = await query.getSingle();

    return TeamMemberDetailsModel(
      id: row.readTable(ratios).id,
      ratio: row.readTable(ratios).ratio,
      member: row.readTable(members),
      team: row.readTable(teams),
    );
  }

  Future<void> updateRatio(TeamMembersEditForm teamMember) async {
    await (db.update(
      db.ratios,
    )..where((tbl) => tbl.id.equals(teamMember.id))).write(
      RatiosCompanion(
        ratio: Value(teamMember.ratio),
        memberID: Value(teamMember.memberID),
        teamID: Value(teamMember.teamID),
      ),
    );
  }

  Future<void> deleteMember(int id) async {
    await (db.delete(db.ratios)..where((tbl) => tbl.id.equals(id))).go();
  }
}
