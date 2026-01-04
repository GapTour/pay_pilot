part of '../event_details_bloc.dart';

class EventTransactionStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventTransactionInitial extends EventTransactionStatus {}

class EventTransactionLoading extends EventTransactionStatus {}

class EventTransactionSuccess extends EventTransactionStatus {
  final ResponseEventTransaction transaction;

  EventTransactionSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class EventTransactionFailure extends EventTransactionStatus {}
