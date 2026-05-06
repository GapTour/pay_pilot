import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guest_details/data/models/response_guest_details.dart';

abstract class IGuestDetailsSource {
  Future<DataState<ResponseGuestDetails>> getGuest(int id);
}
