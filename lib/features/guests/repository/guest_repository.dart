import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/guests/data/sources/i_guest_source.dart';
import 'package:pay_pilot/features/guests/data/sources/local_guest_source.dart';
import 'package:pay_pilot/features/guests/data/sources/remote_guest_source.dart';

abstract class IGuestRepository implements IGuestSource {}

class GuestRepository implements IGuestRepository {
  final LocalGuestSource _localGuestSource;
  final RemoteGuestSource _remoteGuestSource;
  final SharedPreferencesService _preferencesService;
  late bool isOffline;

  GuestRepository(
    LocalGuestSource localGuestSource,
    RemoteGuestSource remoteGuestSource,
    SharedPreferencesService preferencesService,
  ) : _localGuestSource = localGuestSource,
      _remoteGuestSource = remoteGuestSource,
      _preferencesService = preferencesService;

  @override
  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localGuestSource.getAllGuests();
      return await _remoteGuestSource.getAllGuests();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseGuest>> addGuest(GuestParams params) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localGuestSource.addGuest(params);
      return await _remoteGuestSource.addGuest(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseGuest>> editGuest(GuestParams params) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localGuestSource.editGuest(params);
      return await _remoteGuestSource.editGuest(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteGuest(int id) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localGuestSource.deleteGuest(id);
      return await _remoteGuestSource.deleteGuest(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
