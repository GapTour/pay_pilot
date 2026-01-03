part of 'events_cubit.dart';

class EventsState extends Equatable {
  final EventsStatus eventsStatus;
  final List<ResponseEvent> events;
  final List<ResponseTeam> teams;
  const EventsState({
    required this.eventsStatus,
    required this.events,
    required this.teams,
  });

  @override
  List<Object> get props => [eventsStatus, events, teams];

  EventsState copyWith({
    EventsStatus? eventsStatus,
    List<ResponseEvent>? events,
    List<ResponseTeam>? teams,
  }) {
    return EventsState(
      eventsStatus: eventsStatus ?? this.eventsStatus,
      events: events ?? this.events,
      teams: teams ?? this.teams,
    );
  }
}
