import 'package:pay_pilot/core/database/app_database.dart';

class EventRatioForm {
  final double ratio;
  final Member member;
  final int eventID;

  EventRatioForm({
    required this.ratio,
    required this.member,
    required this.eventID,
  });
}
