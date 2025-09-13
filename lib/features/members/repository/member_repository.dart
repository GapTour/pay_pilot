import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/members/data/member_db_provider.dart';
import 'package:pay_pilot/features/members/data/member_editing_form.dart';
import 'package:pay_pilot/features/members/data/member_form.dart';

class MemberRepository {
  final MemberDbProvider _dbProvider;
  MemberRepository(this._dbProvider);

  Future<List<Member>> getAllMembers() async {
    return await _dbProvider.getAllMembers();
  }

  Future<int> insertMember(MemberForm member) async {
    return await _dbProvider.insertMember(member);
  }

  Future<void> updateMember(MemberEditingForm member) async {
    await _dbProvider.updateMember(member);
  }
}
