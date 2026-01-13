import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';

part 'selecting_events_state.dart';

class SelectingEventsCubit extends Cubit<SelectingEventsState> {
  final ReportRepository _repository;
  SelectingEventsCubit(this._repository) : super(SelectingEventsInitial());

  void loadEvents() async {
    emit(SelectingEventsLoading());

    final dataState = await _repository.getAllEvents();

    if (dataState is DataSuccess) {
      emit(SelectingEventsSuccess(events: dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(SelectingEventsFailure());
    }
  }
}
