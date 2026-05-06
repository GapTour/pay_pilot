import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/guest_details/data/models/response_guest_details.dart';
import 'package:pay_pilot/features/guest_details/data/providers/guest_details_api_provider.dart';
import 'package:pay_pilot/features/guest_details/data/sources/i_guest_details_source.dart';

class RemoteGuestDetailsSource implements IGuestDetailsSource {
  final GuestDetailsApiProvider _apiProvider;
  RemoteGuestDetailsSource(this._apiProvider);

  @override
  Future<DataState<ResponseGuestDetails>> getGuest(int id) async {
    try {
      final Response response = await _apiProvider.getGuest(id);

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseGuestDetails.fromApi(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
