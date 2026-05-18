part of '../members_details_cubit.dart';

sealed class MembersStatus extends Equatable {}

class MemberInitial extends MembersStatus {
  @override
  List<Object?> get props => [];
}

class MemberLoading extends MembersStatus {
  @override
  List<Object?> get props => [];
}

class MemberSuccess extends MembersStatus {
  final ResponseMemberDetails member;

  MemberSuccess(this.member);
  @override
  List<Object?> get props => [member];
}

class MemberFailure extends MembersStatus {
  @override
  List<Object?> get props => [];
}
