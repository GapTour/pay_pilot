import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/team_members/repository/team_members_repository.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

part 'ratios_state.dart';
part 'status/team_member_status.dart';

class RatiosCubit extends Cubit<RatiosState> {
  final TeamMembersRepository _repository;
  RatiosCubit(this._repository)
    : super(RatiosState(teamMemberStatus: TeamMemberInitial(), ratios: []));

  void loadRatios(int teamID) async {
    emit(state.copyWith(teamMemberStatus: TeamMemberLoading()));

    final memberDataState = await _repository.getAllMembers();
    final teamDataState = await _repository.getTeamDetails(teamID);

    if (memberDataState is DataSuccess && teamDataState is DataSuccess) {
      final team = teamDataState.data!;
      final members = memberDataState.data!;
      Map<int, double> addedMembers = {};

      final ratiosDataState = await _repository.getAllRatios(teamID);

      if (ratiosDataState is DataSuccess) {
        final teamMembers = ratiosDataState.data!;
        teamMembers.sort((a, b) => a.ratio.compareTo(b.ratio));
        addedMembers = await _updateAddedMembersList(teamMembers);

        emit(state.copyWith(ratios: teamMembers));
      }

      emit(
        state.copyWith(
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }

    if (memberDataState is DataFailed || teamDataState is DataFailed) {
      emit(state.copyWith(teamMemberStatus: TeamMemberFailure()));
    }
  }

  void addRatio(TeamMemberParams params) async {
    final team = (state.teamMemberStatus as TeamMemberSuccess).team;
    final members = (state.teamMemberStatus as TeamMemberSuccess).members;
    Map<int, double> addedMembers =
        (state.teamMemberStatus as TeamMemberSuccess).addedMembers;
    final teamMembers = state.ratios;

    emit(state.copyWith(teamMemberStatus: TeamMemberLoading()));

    final dataState = await _repository.insertRatio(params);

    if (dataState is DataSuccess) {
      final newRatio = dataState.data!;

      teamMembers
        ..add(newRatio)
        ..sort((a, b) => a.ratio.compareTo(b.ratio));
      addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }
  }

  void updateRatio(TeamMemberParams params) async {
    final team = (state.teamMemberStatus as TeamMemberSuccess).team;
    final members = (state.teamMemberStatus as TeamMemberSuccess).members;
    Map<int, double> addedMembers =
        (state.teamMemberStatus as TeamMemberSuccess).addedMembers;
    final teamMembers = state.ratios;

    emit(state.copyWith(teamMemberStatus: TeamMemberLoading()));

    final dataState = await _repository.updateRatio(params);

    if (dataState is DataSuccess) {
      final newRatio = dataState.data!;

      teamMembers
        ..removeWhere((element) => element.id == newRatio.id)
        ..add(newRatio)
        ..sort((a, b) => a.ratio.compareTo(b.ratio));
      addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }
  }

  void deleteRatio(int ratioID) async {
    final team = (state.teamMemberStatus as TeamMemberSuccess).team;
    final members = (state.teamMemberStatus as TeamMemberSuccess).members;
    Map<int, double> addedMembers =
        (state.teamMemberStatus as TeamMemberSuccess).addedMembers;
    final teamMembers = state.ratios;

    emit(state.copyWith(teamMemberStatus: TeamMemberLoading()));

    final dataState = await _repository.deleteRatio(ratioID);

    if (dataState is DataSuccess) {
      teamMembers.removeWhere((element) => element.id == ratioID);
      addedMembers = await _updateAddedMembersList(teamMembers);

      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          ratios: teamMembers,
          teamMemberStatus: TeamMemberSuccess(
            addedMembers: addedMembers,
            team: team,
            members: members,
          ),
        ),
      );
    }
  }

  Future<Map<int, double>> _updateAddedMembersList(
    List<ResponseTeamMember> teamMembers,
  ) async {
    final addedMembers = <int, double>{};

    teamMembers.fold<Map<int, double>>({}, (previousValue, element) {
      if (!previousValue.containsKey(element.memberInfo.id)) {
        addedMembers[element.memberInfo.id] = element.ratio;
      }
      return previousValue;
    });

    return addedMembers;
  }
}
