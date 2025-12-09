import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/guests/repository/guest_repository.dart';

part 'guests_state.dart';

class GuestsCubit extends Cubit<GuestsState> {
  final GuestRepository _repository;
  GuestsCubit(this._repository)
    : super(GuestsState(guestsStatus: GuestsStatus.initial, guests: []));

  void loadGuests() async {
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.getAllGuests();

    if (dataState is DataSuccess) {
      final guests = dataState.data!;

      guests.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      emit(state.copyWith(guestsStatus: GuestsStatus.success, guests: guests));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void addGuest(GuestParams params) async {
    final guests = state.guests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.addGuest(params);

    if (dataState is DataSuccess) {
      final newGuest = dataState.data!;

      guests
        ..add(newGuest)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(state.copyWith(guestsStatus: GuestsStatus.success, guests: guests));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void updateGuest(GuestParams params) async {
    final guests = state.guests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.editGuest(params);

    if (dataState is DataSuccess) {
      final newGuest = dataState.data!;

      guests
        ..removeWhere((element) => element.id == newGuest.id)
        ..add(newGuest)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      emit(state.copyWith(guestsStatus: GuestsStatus.success, guests: guests));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }

  void deleteGuest(int memberID) async {
    final guests = state.guests;
    emit(state.copyWith(guestsStatus: GuestsStatus.loading));

    final dataState = await _repository.deleteGuest(memberID);

    if (dataState is DataSuccess) {
      guests.removeWhere((element) => element.id == memberID);

      emit(state.copyWith(guestsStatus: GuestsStatus.success, guests: guests));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(guestsStatus: GuestsStatus.failure));
    }
  }
}
