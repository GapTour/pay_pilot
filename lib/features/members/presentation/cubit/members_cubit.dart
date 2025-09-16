import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/members/data/member_editing_form.dart';
import 'package:pay_pilot/features/members/data/member_form.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final MemberRepository _repository;
  MembersCubit(this._repository)
    : super(MembersState(membersStatus: MembersStatus.initial, members: []));

  void loadMembers() async {
    emit(state.copyWith(membersStatus: MembersStatus.loading));

    try {
      final members = await _repository.getAllMembers();
      members.sort((a, b) => a.name.compareTo(b.name));

      emit(
        state.copyWith(membersStatus: MembersStatus.success, members: members),
      );
    } catch (_) {
      emit(state.copyWith(membersStatus: MembersStatus.failure));
    }
  }

  void addMember(MemberForm member) async {
    await _repository.insertMember(member).whenComplete(() {
      loadMembers();
    });
  }

  void updateMember(MemberEditingForm member) async {
    await _repository.updateMember(member).whenComplete(() {
      loadMembers();
    });
  }

  void deleteMember(int memberID) async {
    await _repository.deleteMember(memberID).whenComplete(() {
      loadMembers();
    });
  }
}
