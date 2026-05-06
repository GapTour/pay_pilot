import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/guests/data/sources/i_guest_source.dart';

class LocalGuestSource implements IGuestSource {
  final GuestDao _dbService;
  LocalGuestSource(this._dbService);

  @override
  Future<DataState<ResponseGuest>> addGuest(GuestParams params) async {
    try {
      final response = await _dbService.insertGuess(params);
      final guest = ResponseGuest.fromParams(params.copyWith(id: response));

      return DataSuccess(guest);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteGuest(int id) async {
    try {
      await _dbService.deleteGuest(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseGuest>> editGuest(GuestParams params) async {
    try {
      await _dbService.updateGuest(params);
      final guest = ResponseGuest.fromParams(params);

      return DataSuccess(guest);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      final response = await _dbService.getAllGuests();
      final guests = response.map(ResponseGuest.fromDb).toList();

      return DataSuccess(guests);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
