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

  RatioSuccess(this.team, this.members);

  @override
  List<Object?> get props => [team, members];
}

class RatioFailure extends RatiosStatus {}
