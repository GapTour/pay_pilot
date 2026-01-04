part of 'event_details_bloc.dart';

enum EventDetailsPage {
  transactions,
  members,
  orders,
  report;

  bool get isTransactions => this == transactions;
  bool get isMembers => this == members;
  bool get isReport => this == report;
  bool get isOrder => this == orders;
}

class EventDetailsState extends Equatable {
  final EventDetailStatus eventDetailStatus;
  final EventTransactionStatus eventTransactionStatus;
  final EventRatioStatus eventRatioStatus;
  final EventOrderStatus eventOrderStatus;
  final EventReportStatus eventReportStatus;
  final EventDetailsPage currentPage;
  const EventDetailsState({
    required this.eventDetailStatus,
    required this.eventTransactionStatus,
    required this.eventRatioStatus,
    required this.eventOrderStatus,
    required this.eventReportStatus,
    required this.currentPage,
  });

  @override
  List<Object> get props => [
    eventDetailStatus,
    eventTransactionStatus,
    eventRatioStatus,
    eventOrderStatus,
    eventReportStatus,
    currentPage,
  ];

  EventDetailsState copyWith({
    EventDetailStatus? eventDetailStatus,
    EventTransactionStatus? eventTransactionStatus,
    EventRatioStatus? eventRatioStatus,
    EventOrderStatus? eventOrderStatus,
    EventReportStatus? eventReportStatus,
    EventDetailsPage? currentPage,
  }) {
    return EventDetailsState(
      eventDetailStatus: eventDetailStatus ?? this.eventDetailStatus,
      eventTransactionStatus:
          eventTransactionStatus ?? this.eventTransactionStatus,
      eventRatioStatus: eventRatioStatus ?? this.eventRatioStatus,
      eventOrderStatus: eventOrderStatus ?? this.eventOrderStatus,
      eventReportStatus: eventReportStatus ?? this.eventReportStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
