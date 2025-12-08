import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final MemberRepository _repository;
  MembersCubit(this._repository)
    : super(MembersState(membersStatus: MembersStatus.initial, members: []));

  void loadMembers() async {
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    final dataState = await _repository.getAllMembers();

    if (dataState is DataSuccess) {
      final members = dataState.data!;

      members.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(
        state.copyWith(membersStatus: MembersStatus.success, members: members),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void addMember(MemberParams params) async {
    final members = state.members;

    final dataState = await _repository.addMember(params);

    if (dataState is DataSuccess) {
      final newMember = dataState.data!;

      members
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(membersStatus: MembersStatus.success, members: members),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void updateMember(MemberParams params) async {
    final members = state.members;

    final dataState = await _repository.addMember(params);

    if (dataState is DataSuccess) {
      final newMember = dataState.data!;

      members
        ..removeWhere((element) => element.id == newMember.id)
        ..add(newMember)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(
        state.copyWith(membersStatus: MembersStatus.success, members: members),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void deleteMember(int memberID) async {
    final members = state.members;

    final dataState = await _repository.deleteMember(memberID);

    if (dataState is DataSuccess) {
      members.removeWhere((element) => element.id == memberID);

      emit(
        state.copyWith(membersStatus: MembersStatus.success, members: members),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }
}
