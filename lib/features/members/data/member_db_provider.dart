import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/features/members/data/models/member_editing_form.dart';
import 'package:pay_pilot/features/members/data/models/member_form.dart';

class MemberDbProvider {
  final MemberDao _dbService;
  MemberDbProvider(this._dbService);

  Future<List<Member>> getAllMembers() async {
    return await _dbService.getAllMembers();
  }

  Future<int> insertMember(MemberForm member) async {
    return await _dbService.insertMember(member);
  }

  Future<void> updateMember(MemberEditingForm member) async {
    await _dbService.updateMember(member);
  }

  Future<void> deleteMember(int id) async {
    await _dbService.deleteMember(id);
  }
}
