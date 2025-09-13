part of '../ratios_cubit.dart';

class RatiosStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class RatioInitial extends RatiosStatus {}

class RatioLoading extends RatiosStatus {}

class RatioSuccess extends RatiosStatus {
  final Team team;
  final List<Member> members;
  final Map<int, double> addedMembers;

  RatioSuccess(this.team, this.members, this.addedMembers);

  @override
  List<Object?> get props => [team, members, addedMembers];
}

class RatioFailure extends RatiosStatus {}
