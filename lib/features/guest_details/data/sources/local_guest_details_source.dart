import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guest_details/data/models/response_guest_details.dart';
import 'package:pay_pilot/features/guest_details/data/sources/i_guest_details_source.dart';

class LocalGuestDetailsSource implements IGuestDetailsSource {
  final GuestDao _dbService;
  LocalGuestDetailsSource(this._dbService);

  @override
  Future<DataState<ResponseGuestDetails>> getGuest(int id) async {
    try {
      final response = await _dbService.getGuest(id);
      final guest = ResponseGuestDetails.fromDb(response);

      return DataSuccess(guest);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
