import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';

part 'selecting_events_state.dart';

class SelectingEventsCubit extends Cubit<SelectingEventsState> {
  final ReportRepository _repository;
  SelectingEventsCubit(this._repository) : super(SelectingEventsInitial());

  void loadEvents() async {
    emit(SelectingEventsLoading());

    try {
      final events = await _repository.getAllEvents();
      emit(SelectingEventsSuccess(events: events));
    } catch (_) {
      emit(SelectingEventsFailure());
    }
  }
}
