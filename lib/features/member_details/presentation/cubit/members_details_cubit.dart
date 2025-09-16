import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/member_details/repository/member_details_repository.dart';

part 'members_details_state.dart';
part 'status/members_status.dart';

class MembersDetailsCubit extends Cubit<MembersDetailsState> {
  final MemberDetailsRepository _repository;
  MembersDetailsCubit(this._repository)
    : super(MembersDetailsState(membersStatus: MemberInitial()));

  void loadMembers(int id) async {
    emit(state.copyWith(membersStatus: MemberLoading()));

    try {
      final member = await _repository.getMember(id);

      emit(state.copyWith(membersStatus: MemberSuccess(member)));
    } catch (_) {
      emit(state.copyWith(membersStatus: MemberFailure()));
    }
  }
}
