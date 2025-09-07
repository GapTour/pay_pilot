import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/services/db_service.dart';
import 'package:pay_pilot/features/members/data/member_form.dart';

class MemberDbProvider {
  final DatabaseService _dbService;
  MemberDbProvider(this._dbService);

  Future<List<Member>> getAllMembers() async {
    return await _dbService.getAllMembers();
  }

  Future<int> insertMember(MemberForm member) async {
    return await _dbService.insertMember(member);
  }

  Future<void> updateMember(MemberForm member) async {
    await _dbService.updateMember(member);
  }
}
