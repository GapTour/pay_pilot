import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';

class FullReportViewModel {
  final int id;
  final String title;
  final int version;
  final String? description;
  final DateTime generateFor;
  final List<EventDetailsModel> events;
  final List<BalanceModel> membersBalance;

  FullReportViewModel({
    required this.id,
    required this.title,
    required this.version,
    this.description,
    required this.generateFor,
    required this.events,
    required this.membersBalance,
  });
}
