import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';

abstract class IGuestSource {
  Future<DataState<List<ResponseGuest>>> getAllGuests();
  Future<DataState<ResponseGuest>> addGuest(GuestParams params);
  Future<DataState<ResponseGuest>> editGuest(GuestParams params);
  Future<DataState<int>> deleteGuest(int id);
}
