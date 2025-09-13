import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';

class MemberDetailsDbProvider {
  final MemberDao _dbService;
  MemberDetailsDbProvider(this._dbService);

  Future<Member> getMember(int id) async {
    return await _dbService.getMember(id);
  }
}
