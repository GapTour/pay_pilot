import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/members/data/sources/i_member_source.dart';
import 'package:pay_pilot/features/members/data/sources/local_member_source.dart';
import 'package:pay_pilot/features/members/data/sources/remote_member_source.dart';

abstract class IMemberRepository implements IMemberSource {}

class MemberRepository implements IMemberRepository {
  final LocalMemberSource _localMemberSource;
  final RemoteMemberSource _remoteMemberSource;
  final SharedPreferencesService _preferencesService;
  late bool isOffline;

  MemberRepository(
    LocalMemberSource localMemberSource,
    RemoteMemberSource remoteMemberSource,
    SharedPreferencesService preferencesService,
  ) : _localMemberSource = localMemberSource,
      _remoteMemberSource = remoteMemberSource,
      _preferencesService = preferencesService;

  @override
  Future<DataState<ResponseMember>> addMember(MemberParams params) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localMemberSource.addMember(params);
      return await _remoteMemberSource.addMember(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteMember(int id) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localMemberSource.deleteMember(id);
      return await _remoteMemberSource.deleteMember(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseMember>> editMember(MemberParams params) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localMemberSource.editMember(params);
      return await _remoteMemberSource.editMember(params);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localMemberSource.getAllMembers();
      return await _remoteMemberSource.getAllMembers();
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
