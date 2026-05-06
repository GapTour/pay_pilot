import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/events/data/providers/event_api_provider.dart';
import 'package:pay_pilot/features/events/data/sources/i_event_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class RemoteEventSource implements IEventSource {
  final EventApiProvider _apiProvider;
  RemoteEventSource(this._apiProvider);

  @override
  Future<DataState<ResponseEvent>> addEvent(EventParams params) async {
    try {
      final Response response = await _apiProvider.addEvent(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final event = ResponseEvent.fromApi(rawData);

        return DataSuccess(event);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<int>> deleteEvent(int id) async {
    try {
      final Response response = await _apiProvider.deleteEvent(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseEvent>> editEvent(EventParams params) async {
    try {
      final Response response = await _apiProvider.editEvent(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final event = ResponseEvent.fromApi(rawData);

        return DataSuccess(event);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<List<ResponseEvent>>> getAllEvents() async {
    try {
      final Response response = await _apiProvider.getAllEvents();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final events = rawData.map((e) {
          return ResponseEvent.fromApi(e);
        }).toList();

        return DataSuccess(events);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      final Response response = await _apiProvider.getAllTeams();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final teams = rawData.map((e) {
          return ResponseTeam.fromApi(e);
        }).toList();

        return DataSuccess(teams);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
