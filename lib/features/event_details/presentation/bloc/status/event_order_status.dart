part of '../event_details_bloc.dart';

class EventOrderStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventOrderInitial extends EventOrderStatus {}

class EventOrderLoading extends EventOrderStatus {}

class EventOrderSuccess extends EventOrderStatus {
  final ResponseOrder order;

  EventOrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class EventOrderFailure extends EventOrderStatus {}
