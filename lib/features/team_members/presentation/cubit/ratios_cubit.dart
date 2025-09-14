import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/team_members/data/team_members_edit_form.dart';
import 'package:pay_pilot/features/team_members/data/team_members_form.dart';
import 'package:pay_pilot/features/team_members/repository/team_members_repository.dart';

part 'ratios_state.dart';
part 'status/ratios_status.dart';

class RatiosCubit extends Cubit<RatiosState> {
  final TeamMembersRepository _repository;
  RatiosCubit(this._repository)
    : super(RatiosState(ratioStatus: RatioInitial(), ratios: []));

  void loadRatios(int teamID, {Team? team, List<Member>? members}) async {
    late Team? fetchedTeam;
    late List<Member>? fetchedMembers;

    emit(state.copyWith(ratioStatus: RatioLoading()));

    try {
      final ratios = await _repository.getAllRatios(teamID);
      ratios.sort((a, b) => a.ratio.compareTo(b.ratio));

      fetchedTeam = team ?? await _repository.getTeamDetails(teamID);
      fetchedMembers = members ?? await _repository.getAllMembers();

      final Map<int, double> addedMembers = {};
      ratios.fold<Map<int, double>>({}, (previousValue, element) {
        if (!previousValue.containsKey(element.member.id)) {
          addedMembers[element.member.id] = element.ratio;
        }
        return previousValue;
      });

      emit(
        state.copyWith(
          ratioStatus: RatioSuccess(fetchedTeam, fetchedMembers, addedMembers),
          ratios: ratios,
        ),
      );
    } catch (_) {
      emit(state.copyWith(ratioStatus: RatioFailure()));
    }
  }

  void addRatio(TeamMembersForm teamMember) async {
    bool isSuccess = false;

    await _repository.insertRatio(teamMember).whenComplete(() {
      if (state.ratioStatus is RatioSuccess) isSuccess = true;

      loadRatios(
        teamMember.teamID,
        team: isSuccess ? (state.ratioStatus as RatioSuccess).team : null,
        members: isSuccess ? (state.ratioStatus as RatioSuccess).members : null,
      );
    });
  }

  void updateRatio(TeamMembersEditForm teamMember) async {
    bool isSuccess = false;

    await _repository.updateRatio(teamMember).whenComplete(() {
      if (state.ratioStatus is RatioSuccess) isSuccess = true;

      loadRatios(
        teamMember.teamID,
        team: isSuccess ? (state.ratioStatus as RatioSuccess).team : null,
        members: isSuccess ? (state.ratioStatus as RatioSuccess).members : null,
      );
    });
  }

  void deleteRatio(int teamID, int teamMemberID) async {
    bool isSuccess = false;

    await _repository.deleteRatio(teamMemberID).whenComplete(() {
      if (state.ratioStatus is RatioSuccess) isSuccess = true;

      loadRatios(
        teamID,
        team: isSuccess ? (state.ratioStatus as RatioSuccess).team : null,
        members: isSuccess ? (state.ratioStatus as RatioSuccess).members : null,
      );
    });
  }
}
