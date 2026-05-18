part of '../events_cubit.dart';

class EventsStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventInitial extends EventsStatus {}

class EventLoading extends EventsStatus {}

class EventSuccess extends EventsStatus {}

class EventFailure extends EventsStatus {}
