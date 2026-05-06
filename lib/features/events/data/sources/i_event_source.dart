import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

abstract class IEventSource {
  Future<DataState<List<ResponseEvent>>> getAllEvents();
  Future<DataState<List<ResponseTeam>>> getAllTeams();
  Future<DataState<ResponseEvent>> addEvent(EventParams params);
  Future<DataState<ResponseEvent>> editEvent(EventParams params);
  Future<DataState<int>> deleteEvent(int id);
}
