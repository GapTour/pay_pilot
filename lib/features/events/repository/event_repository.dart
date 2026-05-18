import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/events/data/sources/local_event_source.dart';
import 'package:pay_pilot/features/events/data/sources/remote_event_source.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class EventRepository {
  final LocalEventSource _localEventSource;
  final RemoteEventSource _remoteEventSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  EventRepository(
    this._localEventSource,
    this._remoteEventSource,
    this._preferencesService,
  );

  Future<DataState<List<ResponseEvent>>> getAllEvents() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventSource.getAllEvents();
      return await _remoteEventSource.getAllEvents();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<List<ResponseTeam>>> getAllTeams() async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventSource.getAllTeams();
      return await _remoteEventSource.getAllTeams();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseEvent>> addEvent(EventParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventSource.addEvent(params);
      return await _remoteEventSource.addEvent(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<ResponseEvent>> editEvent(EventParams params) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventSource.editEvent(params);
      return await _remoteEventSource.editEvent(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  Future<DataState<int>> deleteEvent(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: true,
      );

      if (isOffline!) return await _localEventSource.deleteEvent(id);
      return await _remoteEventSource.deleteEvent(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
