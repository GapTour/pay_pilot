import 'package:pay_pilot/core/database/app_database.dart';

class MemberRatioModel {
  final int id;
  final double ratio;
  final Member member;

  MemberRatioModel({
    required this.id,
    required this.ratio,
    required this.member,
  });
}
