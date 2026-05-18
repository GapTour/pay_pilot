import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/member_details/data/models/response_member_details.dart';
import 'package:pay_pilot/features/member_details/data/sources/i_member_details_source.dart';
import 'package:pay_pilot/features/member_details/data/sources/local_member_details_source.dart';
import 'package:pay_pilot/features/member_details/data/sources/remote_member_details_source.dart';

abstract class IMemberDetailsRepository implements IMemberDetailsSource {}

class MemberDetailsRepository implements IMemberDetailsRepository {
  final LocalMemberDetailsSource _localMemberDetailsSource;
  final RemoteMemberDetailsSource _remoteMemberDetailsSource;
  final SharedPreferencesService _preferencesService;
  late bool isOffline;

  MemberDetailsRepository(
    LocalMemberDetailsSource localMemberSource,
    RemoteMemberDetailsSource remoteMemberSource,
    SharedPreferencesService preferencesService,
  ) : _localMemberDetailsSource = localMemberSource,
      _remoteMemberDetailsSource = remoteMemberSource,
      _preferencesService = preferencesService;

  @override
  Future<DataState<ResponseMemberDetails>> getMember(int id) async {
    try {
      isOffline =
          await _preferencesService.read<bool>(AppArguments.mode) ?? false;

      if (isOffline) return await _localMemberDetailsSource.getMember(id);
      return await _remoteMemberDetailsSource.getMember(id);
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
