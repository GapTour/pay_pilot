// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_details_cubit.dart';

enum EventDetailsPage { transactions, members, report }

class EventDetailsState extends Equatable {
  final EventDetailsPage currentPage;
  final EventDetailStatus eventDetailStatus;
  const EventDetailsState({
    required this.currentPage,
    required this.eventDetailStatus,
  });

  @override
  List<Object> get props => [currentPage, eventDetailStatus];

  EventDetailsState copyWith({
    EventDetailsPage? currentPage,
    EventDetailStatus? eventDetailStatus,
  }) {
    return EventDetailsState(
      currentPage: currentPage ?? this.currentPage,
      eventDetailStatus: eventDetailStatus ?? this.eventDetailStatus,
    );
  }
}
