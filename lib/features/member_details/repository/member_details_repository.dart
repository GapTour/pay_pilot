import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/member_details/data/member_details_db_provider.dart';

class MemberDetailsRepository {
  final MemberDetailsDbProvider _dbProvider;
  MemberDetailsRepository(this._dbProvider);

  Future<Member> getMember(int id) async {
    return await _dbProvider.getMember(id);
  }
}
