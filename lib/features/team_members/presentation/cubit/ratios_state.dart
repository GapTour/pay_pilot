part of 'ratios_cubit.dart';

@immutable
class RatiosState extends Equatable {
  final TeamMemberStatus teamMemberStatus;
  final List<ResponseTeamMember> ratios;

  const RatiosState({required this.teamMemberStatus, required this.ratios});

  @override
  List<Object?> get props => [ratios, teamMemberStatus];

  RatiosState copyWith({
    TeamMemberStatus? teamMemberStatus,
    List<ResponseTeamMember>? ratios,
  }) {
    return RatiosState(
      teamMemberStatus: teamMemberStatus ?? this.teamMemberStatus,
      ratios: ratios ?? this.ratios,
    );
  }
}
