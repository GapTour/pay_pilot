import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/teams/data/team_edit_form.dart';
import 'package:pay_pilot/features/teams/data/team_form.dart';
import 'package:pay_pilot/features/teams/repository/team_repository.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final TeamRepository _repository;
  TeamsCubit(this._repository)
    : super(TeamsState(teamsStatus: TeamsStatus.initial, teams: []));

  void loadTeams() async {
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    try {
      final members = await _repository.getAllTeams();
      members.sort((a, b) => a.title.compareTo(b.title));

      emit(state.copyWith(teamsStatus: TeamsStatus.success, teams: members));
    } catch (_) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void addTeam(TeamForm team) async {
    await _repository.insertTeam(team).whenComplete(() {
      loadTeams();
    });
  }

  void updateTeam(TeamEditForm team) async {
    await _repository.updateTeam(team).whenComplete(() {
      loadTeams();
    });
  }

  void deleteTeam(int teamID) async {
    await _repository.deleteTeam(teamID).whenComplete(() {
      loadTeams();
    });
  }
}
