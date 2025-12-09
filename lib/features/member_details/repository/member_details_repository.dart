import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/member_details/data/member_details_api_provider.dart';
import 'package:pay_pilot/features/member_details/data/models/response_member_details.dart';

class MemberDetailsRepository {
  // final MemberDetailsDbProvider _dbProvider;
  final MemberDetailsApiProvider _apiProvider;
  MemberDetailsRepository(
    this._apiProvider,
    // this._dbProvider
  );

  Future<DataState<ResponseMemberDetails>> getMember(int id) async {
    try {
      final Response response = await _apiProvider.getMember(id);

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseMemberDetails.fromMap(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
