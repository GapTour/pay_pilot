import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';

part 'team_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamDao extends DatabaseAccessor<AppDatabase> with _$TeamDaoMixin {
  TeamDao(super.db);

  Future<int> insertTeam(TeamParams team) async {
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

  Future<void> updateTeam(TeamParams team) async {
    await (db.update(db.teams)..where((tbl) => tbl.id.equals(team.id!))).write(
      TeamsCompanion(
        title: Value(team.title),
        description: Value(team.description),
        isActive: Value(team.isActive),
      ),
    );
  }

  Future<void> deleteTeam(int id) async {
    await (db.delete(db.teams)..where((tbl) => tbl.id.equals(id))).go();
  }
}
