part of '../event_details_bloc.dart';

class EventTransactionStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventTransactionInitial extends EventTransactionStatus {}

class EventTransactionLoading extends EventTransactionStatus {}

class EventTransactionSuccess extends EventTransactionStatus {
  final List<ResponseEventTransaction> transactions;

  EventTransactionSuccess(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class EventTransactionFailure extends EventTransactionStatus {}
