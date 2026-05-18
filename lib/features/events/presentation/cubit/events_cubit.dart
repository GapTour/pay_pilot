import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/events/repository/event_repository.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

part 'events_state.dart';
part 'status/events_status.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventRepository _repository;
  EventsCubit(this._repository)
    : super(EventsState(eventsStatus: EventInitial(), events: [], teams: []));

  void loadEvents() async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final eventsDataState = await _repository.getAllEvents();

    if (eventsDataState is DataSuccess) {
      final events = eventsDataState.data!
        ..sort((a, b) => b.date.compareTo(a.date));

      emit(state.copyWith(eventsStatus: EventSuccess(), events: events));

      final teamsDataState = await _repository.getAllTeams();

      if (teamsDataState is DataSuccess) {
        emit(
          state.copyWith(
            teams: teamsDataState.data!
              ..sort(
                (a, b) =>
                    a.title.toLowerCase().compareTo(b.title.toLowerCase()),
              ),
          ),
        );
      }
    }

    if (eventsDataState is DataFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void addEvent(EventParams params) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.addEvent(params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventsStatus: EventSuccess(),
          events: state.events
            ..add(dataState.data!)
            ..sort((a, b) => b.date.compareTo(a.date)),
        ),
      );
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void editEvent(EventParams params) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.editEvent(params);

    if (dataState is DataSuccess) {
      final updatedEvent = dataState.data!;

      final events = state.events;
      final index = events.indexWhere((event) => event.id == updatedEvent.id);

      if (index != -1) {
        events[index] = updatedEvent;
        events.sort((a, b) => b.date.compareTo(a.date));
      }

      emit(state.copyWith(eventsStatus: EventSuccess(), events: events));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }

  void deleteEvent(int eventID) async {
    emit(state.copyWith(eventsStatus: EventLoading()));

    final dataState = await _repository.deleteEvent(eventID);

    if (dataState is DataSuccess) {
      final events = state.events..removeWhere((event) => event.id == eventID);

      emit(state.copyWith(eventsStatus: EventSuccess(), events: events));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventsStatus: EventFailure()));
    }
  }
}
