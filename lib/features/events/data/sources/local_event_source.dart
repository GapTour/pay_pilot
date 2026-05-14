import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/events/data/sources/i_event_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class LocalEventSource implements IEventSource {
  final EventDao _dbServiceForEvent;
  final TeamDao _dbServiceForTeam;

  LocalEventSource(this._dbServiceForEvent, this._dbServiceForTeam);

  @override
  Future<DataState<ResponseEvent>> addEvent(EventParams params) async {
    try {
      final response = await _dbServiceForEvent.insertEvent(params);
      final event = ResponseEvent.fromParams(params.copyWith(id: response));

      return DataSuccess(event);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteEvent(int id) async {
    try {
      await _dbServiceForEvent.archiveEvent(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEvent>> editEvent(EventParams params) async {
    try {
      await _dbServiceForEvent.updateEvent(params);
      final event = ResponseEvent.fromParams(params);

      return DataSuccess(event);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseEvent>>> getAllEvents() async {
    try {
      final response = await _dbServiceForEvent.getAllEvents();
      final events = response.map(ResponseEvent.fromDb).toList();

      return DataSuccess(events);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      final response = await _dbServiceForTeam.getAllTeams();
      final teams = response.map(ResponseTeam.fromDb).toList();

      return DataSuccess(teams);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
