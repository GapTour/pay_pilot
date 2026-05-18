part of 'teams_cubit.dart';

enum TeamsStatus { initial, loading, success, failure }

@immutable
class TeamsState extends Equatable {
  final TeamsStatus teamsStatus;
  final List<ResponseTeam> teams;

  const TeamsState({required this.teamsStatus, required this.teams});

  @override
  List<Object?> get props => [teamsStatus, teams];

  TeamsState copyWith({TeamsStatus? teamsStatus, List<ResponseTeam>? teams}) {
    return TeamsState(
      teamsStatus: teamsStatus ?? this.teamsStatus,
      teams: teams ?? this.teams,
    );
  }
}
