import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';

class MemberDbProvider {
  final MemberDao _dbService;
  MemberDbProvider(this._dbService);

  Future<List<Member>> getAllMembers() async {
    return await _dbService.getAllMembers();
  }

  Future<int> insertMember(MemberParams member) async {
    return await _dbService.insertMember(member);
  }

  Future<void> updateMember(MemberParams member) async {
    await _dbService.updateMember(member);
  }

  Future<void> deleteMember(int id) async {
    await _dbService.deleteMember(id);
  }
}
