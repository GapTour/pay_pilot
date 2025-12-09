import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guest_details/data/models/response_guest_details.dart';
import 'package:pay_pilot/features/guest_details/repository/guest_details_repository.dart';

part 'guests_details_state.dart';
part 'status/guests_status.dart';

class GuestsDetailsCubit extends Cubit<GuestsDetailsState> {
  final GuestDetailsRepository _repository;
  GuestsDetailsCubit(this._repository)
    : super(GuestsDetailsState(guestsStatus: GuestInitial()));

  void loadGuestDetails(int id) async {
    emit(state.copyWith(guestsStatus: GuestLoading()));

    final dataState = await _repository.getGuest(id);

    if (dataState is DataSuccess) {
      emit(state.copyWith(guestsStatus: GuestSuccess(dataState.data!)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(guestsStatus: GuestFailure()));
    }
  }
}
