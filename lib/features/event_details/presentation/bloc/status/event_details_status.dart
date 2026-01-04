part of '../event_details_bloc.dart';

class EventDetailStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventDetailInitial extends EventDetailStatus {}

class EventDetailLoading extends EventDetailStatus {}

class EventDetailSuccess extends EventDetailStatus {
  final ResponseEventDetails eventDetails;
  final List<ResponseMember> members;
  final List<ResponseGuest> guests;
  final List<ResponseMenu> menuItems;

  EventDetailSuccess(
    this.eventDetails,
    this.members,
    this.guests,
    this.menuItems,
  );

  @override
  List<Object?> get props => [eventDetails, members, guests, menuItems];
}

class EventDetailFailure extends EventDetailStatus {}
