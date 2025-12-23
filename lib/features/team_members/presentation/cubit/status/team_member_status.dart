part of '../ratios_cubit.dart';

class TeamMemberStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class TeamMemberInitial extends TeamMemberStatus {}

class TeamMemberLoading extends TeamMemberStatus {}

class TeamMemberSuccess extends TeamMemberStatus {
  final ResponseTeam team;
  final List<ResponseMember> members;
  final Map<int, double> addedMembers;

  TeamMemberSuccess({
    required this.team,
    required this.members,
    required this.addedMembers,
  });

  @override
  List<Object?> get props => [team, members, addedMembers];
}

class TeamMemberFailure extends TeamMemberStatus {}
