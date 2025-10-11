part of '../event_details_cubit.dart';

class EventDetailStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventDetailInitial extends EventDetailStatus {}

class EventDetailLoading extends EventDetailStatus {}

class EventDetailSuccess extends EventDetailStatus {
  final EventDetailsModel eventDetails;

  EventDetailSuccess(this.eventDetails);

  @override
  List<Object?> get props => [eventDetails];
}

class EventDetailFailure extends EventDetailStatus {}
