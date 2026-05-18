part of 'guests_cubit.dart';

enum GuestsStatus { initial, loading, success, failure }

@immutable
class GuestsState extends Equatable {
  final GuestsStatus guestsStatus;
  final List<ResponseGuest> guests;

  const GuestsState({required this.guestsStatus, required this.guests});

  @override
  List<Object?> get props => [guestsStatus, guests];

  GuestsState copyWith({
    GuestsStatus? guestsStatus,
    List<ResponseGuest>? guests,
  }) {
    return GuestsState(
      guestsStatus: guestsStatus ?? this.guestsStatus,
      guests: guests ?? this.guests,
    );
  }
}
