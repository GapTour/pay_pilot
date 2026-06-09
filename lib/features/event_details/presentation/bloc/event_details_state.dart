part of 'event_details_bloc.dart';

enum EventDetailsPage {
  details,
  transactions,
  members,
  orders,
  report;

  bool get isTransactions => this == transactions;
  bool get isMembers => this == members;
  bool get isReport => this == report;
  bool get isOrder => this == orders;
  bool get isDetails => this == details;
}

class EventDetailsState extends Equatable {
  final double totalIncomes;
  final double totalExpenses;
  final EventDetailStatus eventDetailStatus;
  final EventTransactionStatus eventTransactionStatus;
  final EventRatioStatus eventRatioStatus;
  final EventOrderStatus eventOrderStatus;
  final EventReportStatus eventReportStatus;
  final EventDetailsPage currentPage;
  final List<int> filteredOrders;
  const EventDetailsState({
    required this.totalIncomes,
    required this.totalExpenses,
    required this.eventDetailStatus,
    required this.eventTransactionStatus,
    required this.eventRatioStatus,
    required this.eventOrderStatus,
    required this.eventReportStatus,
    required this.currentPage,
    required this.filteredOrders,
  });

  @override
  List<Object> get props {
    return [
      totalIncomes,
      totalExpenses,
      eventDetailStatus,
      eventTransactionStatus,
      eventRatioStatus,
      eventOrderStatus,
      eventReportStatus,
      currentPage,
      filteredOrders,
    ];
  }

  EventDetailsState copyWith({
    double? totalIncomes,
    double? totalExpenses,
    EventDetailStatus? eventDetailStatus,
    EventTransactionStatus? eventTransactionStatus,
    EventRatioStatus? eventRatioStatus,
    EventOrderStatus? eventOrderStatus,
    EventReportStatus? eventReportStatus,
    EventDetailsPage? currentPage,
    List<int>? filteredOrders,
  }) {
    return EventDetailsState(
      totalIncomes: totalIncomes ?? this.totalIncomes,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      eventDetailStatus: eventDetailStatus ?? this.eventDetailStatus,
      eventTransactionStatus:
          eventTransactionStatus ?? this.eventTransactionStatus,
      eventRatioStatus: eventRatioStatus ?? this.eventRatioStatus,
      eventOrderStatus: eventOrderStatus ?? this.eventOrderStatus,
      eventReportStatus: eventReportStatus ?? this.eventReportStatus,
      currentPage: currentPage ?? this.currentPage,
      filteredOrders: filteredOrders ?? this.filteredOrders,
    );
  }
}
