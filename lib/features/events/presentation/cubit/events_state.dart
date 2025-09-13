part of 'events_cubit.dart';

class EventsState extends Equatable {
  final EventsStatus eventsStatus;
  final List<EventModel> events;
  const EventsState({required this.eventsStatus, required this.events});

  @override
  List<Object> get props => [eventsStatus, events];

  EventsState copyWith({EventsStatus? eventsStatus, List<EventModel>? events}) {
    return EventsState(
      eventsStatus: eventsStatus ?? this.eventsStatus,
      events: events ?? this.events,
    );
  }
}
