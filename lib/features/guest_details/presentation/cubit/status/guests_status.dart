part of '../guests_details_cubit.dart';

sealed class GuestsStatus extends Equatable {}

class GuestInitial extends GuestsStatus {
  @override
  List<Object?> get props => [];
}

class GuestLoading extends GuestsStatus {
  @override
  List<Object?> get props => [];
}

class GuestSuccess extends GuestsStatus {
  final ResponseGuestDetails guest;

  GuestSuccess(this.guest);
  @override
  List<Object?> get props => [guest];
}

class GuestFailure extends GuestsStatus {
  @override
  List<Object?> get props => [];
}
