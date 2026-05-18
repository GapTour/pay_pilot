import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class ResponseTeamMember {
  final int id;
  final ResponseMember memberInfo;
  final double ratio;

  ResponseTeamMember({
    required this.id,
    required this.memberInfo,
    required this.ratio,
  });

  factory ResponseTeamMember.fromApi(Map<String, dynamic> map) {
    return ResponseTeamMember(
      id: int.parse(map['id'] as String),
      memberInfo: ResponseMember.fromApi(map['member'] as Map<String, dynamic>),
      ratio: double.parse(map['ratio_value'] as String),
    );
  }

  factory ResponseTeamMember.fromParams(
    TeamMemberParams teamMemberParams,
    Member member,
  ) {
    return ResponseTeamMember(
      id: teamMemberParams.teamID,
      memberInfo: ResponseMember.fromDb(member),
      ratio: teamMemberParams.ratio,
    );
  }

  factory ResponseTeamMember.fromDb(TeamMemberDetailsModel dataModel) {
    return ResponseTeamMember(
      id: dataModel.id,
      memberInfo: ResponseMember(
        id: dataModel.member.id,
        name: dataModel.member.name,
        description: dataModel.member.description,
        joinAt: dataModel.member.joinAt,
        isActive: dataModel.member.isActive,
        profileImage: dataModel.member.profileImage,
        birthday: dataModel.member.birthday,
      ),
      ratio: dataModel.ratio,
    );
  }
}
