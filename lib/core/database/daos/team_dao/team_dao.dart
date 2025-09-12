import 'package:drift/drift.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/features/teams/data/team_edit_form.dart';
import 'package:pay_pilot/features/teams/data/team_form.dart';

part 'team_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamDao extends DatabaseAccessor<AppDatabase> with _$TeamDaoMixin {
  TeamDao(super.db);

  Future<int> insertTeam(TeamForm team) async {
    return await db
        .into(db.teams)
        .insert(
          TeamsCompanion(
            title: Value(team.title),
            description: Value(team.description),
          ),
        );
  }

  Future<List<Team>> getAllTeams() async {
    return await db.select(db.teams).get();
  }

  Future<Team> getTeam(int id) async {
    return (db.select(db.teams)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateTeam(TeamEditForm team) async {
    await (db.update(db.teams)..where((tbl) => tbl.id.equals(team.id))).write(
      TeamsCompanion(
        title: Value(team.title),
        description: Value(team.description),
      ),
    );
  }

  Future<void> deleteMember(int id) async {
    await (db.delete(db.members)..where((tbl) => tbl.id.equals(id))).go();
  }
}
