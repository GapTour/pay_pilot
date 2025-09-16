part of 'ratios_cubit.dart';

@immutable
class RatiosState extends Equatable {
  final RatiosStatus ratioStatus;
  final List<TeamMemberDetailsModel> ratios;

  const RatiosState({required this.ratioStatus, required this.ratios});

  @override
  List<Object?> get props => [ratioStatus, ratios];

  RatiosState copyWith({
    RatiosStatus? ratioStatus,
    List<TeamMemberDetailsModel>? ratios,
  }) {
    return RatiosState(
      ratioStatus: ratioStatus ?? this.ratioStatus,
      ratios: ratios ?? this.ratios,
    );
  }
}
