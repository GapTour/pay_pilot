import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/member_api_provider.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class MemberRepository {
  // final MemberDbProvider _dbProvider;
  final MemberApiProvider _apiProvider;
  MemberRepository(
    // this._dbProvider,
    this._apiProvider,
  );

  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final Response response = await _apiProvider.getAllMembers();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseMember.fromMap(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseMember>> addMember(MemberParams params) async {
    try {
      final Response response = await _apiProvider.addMember(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseMember.fromMap(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseMember>> editMember(MemberParams params) async {
    try {
      final Response response = await _apiProvider.editMember(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'] as dynamic;
        final member = ResponseMember.fromMap(rawData);

        return DataSuccess(member);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<int>> deleteMember(int id) async {
    try {
      final Response response = await _apiProvider.deleteMember(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
