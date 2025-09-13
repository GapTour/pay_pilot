import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/events/data/event_edit_form.dart';
import 'package:pay_pilot/features/events/data/event_form.dart';
import 'package:pay_pilot/features/events/repository/event_repository.dart';

part 'events_state.dart';
part 'status/events_status.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventRepository _repository;
  EventsCubit(this._repository)
    : super(EventsState(eventsStatus: EventInitial(), events: []));

  void loadEvents({List<Team>? teams}) async {
    late List<Team> fetchedTeams;

    emit(state.copyWith(eventsStatus: EventLoading()));

    try {
      final events = await _repository.getAllEvents();
      events.sort((a, b) => b.date.compareTo(a.date));

      fetchedTeams = teams ??= await _repository.getAllTeams();

      emit(
        state.copyWith(
          eventsStatus: EventSuccess(fetchedTeams),
          events: events,
        ),
      );
    } catch (_) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void addIncome(EventForm event) async {
    bool isSuccess = false;

    await _repository.insertEvent(event).whenComplete(() {
      if (state.eventsStatus is EventSuccess) isSuccess = true;

      loadEvents(
        teams: isSuccess ? (state.eventsStatus as EventSuccess).teams : null,
      );
    });
  }

  void updateIncome(EventEditForm event) async {
    bool isSuccess = false;

    await _repository.updateEvent(event).whenComplete(() {
      if (state.eventsStatus is EventSuccess) isSuccess = true;

      loadEvents(
        teams: isSuccess ? (state.eventsStatus as EventSuccess).teams : null,
      );
    });
  }
}
