import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';
import 'package:pay_pilot/features/teams/repository/team_repository.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final TeamRepository _repository;
  TeamsCubit(this._repository)
    : super(TeamsState(teamsStatus: TeamsStatus.initial, teams: []));

  void loadTeams() async {
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.getAllTeams();

    if (dataState is DataSuccess) {
      final teams = dataState.data!;

      teams.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      emit(state.copyWith(teamsStatus: TeamsStatus.success, teams: teams));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void addTeam(TeamParams params) async {
    final teams = state.teams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.addTeam(params);

    if (dataState is DataSuccess) {
      final newTeam = dataState.data!;

      teams
        ..add(newTeam)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(state.copyWith(teamsStatus: TeamsStatus.success, teams: teams));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void updateTeam(TeamParams params) async {
    final teams = state.teams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.editTeam(params);

    if (dataState is DataSuccess) {
      final newTeam = dataState.data!;

      teams
        ..removeWhere((element) => element.id == newTeam.id)
        ..add(newTeam)
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

      emit(state.copyWith(teamsStatus: TeamsStatus.success, teams: teams));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }

  void deleteTeam(int teamID) async {
    final teams = state.teams;
    emit(state.copyWith(teamsStatus: TeamsStatus.loading));

    final dataState = await _repository.deleteTeam(teamID);

    if (dataState is DataSuccess) {
      teams.removeWhere((element) => element.id == teamID);

      emit(state.copyWith(teamsStatus: TeamsStatus.success, teams: teams));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(teamsStatus: TeamsStatus.failure));
    }
  }
}
