import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/members.dart';

part 'member_dao.g.dart';

@DriftAccessor(tables: [Members])
class MemberDao extends DatabaseAccessor<AppDatabase> with _$MemberDaoMixin {
  MemberDao(super.db);

  Future<int> insertMember(MemberParams member) async {
    return await db
        .into(db.members)
        .insert(
          MembersCompanion(
            name: Value(member.name),
            joinAt: Value(member.joinAt),
            description: Value(member.description),
            birthday: Value(member.birthday),
            profileImage: Value(member.profileImage),
          ),
        );
  }

  Future<List<Member>> getAllMembers() async {
    return await db.select(db.members).get();
  }

  Future<Member> getMember(int id) async {
    return (db.select(
      db.members,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateMember(MemberParams member) async {
    await (db.update(
      db.members,
    )..where((tbl) => tbl.id.equals(member.id!))).write(
      MembersCompanion(
        name: Value(member.name),
        joinAt: Value(member.joinAt),
        description: Value(member.description),
        birthday: Value(member.birthday),
        profileImage: Value(member.profileImage),
        isActive: Value(member.isActive ?? true),
      ),
    );
  }

  Future<void> deleteMember(int id) async {
    await (db.delete(db.members)..where((tbl) => tbl.id.equals(id))).go();
  }
}
