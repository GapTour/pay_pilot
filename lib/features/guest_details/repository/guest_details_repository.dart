// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/guest_details/data/models/response_guest_details.dart';
import 'package:pay_pilot/features/guest_details/data/sources/i_guest_details_source.dart';
import 'package:pay_pilot/features/guest_details/data/sources/local_guest_details_source.dart';
import 'package:pay_pilot/features/guest_details/data/sources/remote_guest_details_source.dart';

abstract class IGuestDetailsRepository implements IGuestDetailsSource {}

class GuestDetailsRepository implements IGuestDetailsRepository {
  final LocalGuestDetailsSource _localGuestDetailsSource;
  final RemoteGuestDetailsSource _remoteGuestDetailsSource;
  final SharedPreferencesService _preferencesService;
  late bool? isOffline;

  GuestDetailsRepository(
    this._localGuestDetailsSource,
    this._remoteGuestDetailsSource,
    this._preferencesService,
  );

  @override
  Future<DataState<ResponseGuestDetails>> getGuest(int id) async {
    try {
      isOffline = await _preferencesService.read<bool>(
        AppArguments.mode,
        defaultValue: false,
      );

      if (isOffline!) return await _localGuestDetailsSource.getGuest(id);
      return await _remoteGuestDetailsSource.getGuest(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
