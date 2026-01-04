part of '../event_details_bloc.dart';

class EventRatioStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventRatioInitial extends EventRatioStatus {}

class EventRatioLoading extends EventRatioStatus {}

class EventRatioSuccess extends EventRatioStatus {
  final ResponseEventRatio ratio;

  EventRatioSuccess(this.ratio);

  @override
  List<Object?> get props => [ratio];
}

class EventRatioFailure extends EventRatioStatus {}
