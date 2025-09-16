part of 'selecting_events_cubit.dart';

sealed class SelectingEventsState extends Equatable {
  const SelectingEventsState();

  @override
  List<Object> get props => [];
}

final class SelectingEventsInitial extends SelectingEventsState {}

final class SelectingEventsLoading extends SelectingEventsState {}

class SelectingEventsSuccess extends SelectingEventsState {
  final List<EventDetailsModel> events;

  const SelectingEventsSuccess({required this.events});
  @override
  List<Object> get props => [events];
}

final class SelectingEventsFailure extends SelectingEventsState {}
