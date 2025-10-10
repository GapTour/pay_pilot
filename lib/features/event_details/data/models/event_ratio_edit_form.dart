import 'package:pay_pilot/core/database/app_database.dart';

class EventRatioEditForm {
  final int id;
  final double ratio;
  final Member member;
  final int eventID;

  EventRatioEditForm({
    required this.id,
    required this.ratio,
    required this.member,
    required this.eventID,
  });
}
