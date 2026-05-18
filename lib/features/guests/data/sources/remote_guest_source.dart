import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/guests/data/providers/guest_api_provider.dart';
import 'package:pay_pilot/features/guests/data/sources/i_guest_source.dart';

class RemoteGuestSource implements IGuestSource {
  final GuestApiProvider _apiProvider;
  RemoteGuestSource(this._apiProvider);

  @override
  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      final Response response = await _apiProvider.getAllGuests();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseGuest.fromApi(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseGuest>> addGuest(GuestParams params) async {
    try {
      final Response response = await _apiProvider.addGuest(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseGuest.fromApi(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<ResponseGuest>> editGuest(GuestParams params) async {
    try {
      final Response response = await _apiProvider.editGuest(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseGuest.fromApi(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  @override
  Future<DataState<int>> deleteGuest(int id) async {
    try {
      final Response response = await _apiProvider.deleteGuest(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
