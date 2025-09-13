part of 'event_transactions_cubit.dart';

sealed class EventTransactionsState extends Equatable {
  const EventTransactionsState();

  @override
  List<Object> get props => [];
}

final class EventTransactionsInitial extends EventTransactionsState {}

final class EventTransactionsLoading extends EventTransactionsState {}

final class EventTransactionsSuccess extends EventTransactionsState {
  final EventDetailsModel eventDetails;

  const EventTransactionsSuccess(this.eventDetails);

  @override
  List<Object> get props => [eventDetails];
}

final class EventTransactionsFailure extends EventTransactionsState {}
