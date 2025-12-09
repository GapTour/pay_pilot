part of 'guests_details_cubit.dart';

@immutable
class GuestsDetailsState extends Equatable {
  final GuestsStatus guestsStatus;

  const GuestsDetailsState({required this.guestsStatus});

  @override
  List<Object?> get props => [guestsStatus];

  GuestsDetailsState copyWith({GuestsStatus? guestsStatus}) {
    return GuestsDetailsState(guestsStatus: guestsStatus ?? this.guestsStatus);
  }
}
