import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/members/data/sources/i_member_source.dart';

class LocalMemberSource implements IMemberSource {
  final MemberDao _dbService;
  LocalMemberSource(this._dbService);

  @override
  Future<DataState<ResponseMember>> addMember(MemberParams params) async {
    try {
      final response = await _dbService.insertMember(params);
      final member = ResponseMember.fromParams(params.copyWith(id: response));

      return DataSuccess(member);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteMember(int id) async {
    try {
      await _dbService.deleteMember(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseMember>> editMember(MemberParams params) async {
    try {
      await _dbService.updateMember(params);
      final member = ResponseMember.fromParams(params);

      return DataSuccess(member);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final response = await _dbService.getAllMembers();
      final members = response.map(ResponseMember.fromDb).toList();

      return DataSuccess(members);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
