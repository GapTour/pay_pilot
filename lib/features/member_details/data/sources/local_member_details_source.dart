import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/member_details/data/models/response_member_details.dart';
import 'package:pay_pilot/features/member_details/data/sources/i_member_details_source.dart';

class LocalMemberDetailsSource implements IMemberDetailsSource {
  final MemberDao _dbService;
  LocalMemberDetailsSource(this._dbService);

  @override
  Future<DataState<ResponseMemberDetails>> getMember(int id) async {
    try {
      final response = await _dbService.getMember(id);
      final member = ResponseMemberDetails.fromDb(response);

      return DataSuccess(member);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
