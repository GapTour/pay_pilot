import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';

class RawEventDetailsModel {
  final int id;
  final List<TransactionModel> transactions;
  final List<MemberRatioModel> memberRatios;
  final Team team;

  RawEventDetailsModel({
    required this.id,
    required this.transactions,
    required this.memberRatios,
    required this.team,
  });

  factory RawEventDetailsModel.fromEventDetails(
    EventDetailsModel eventDetails,
  ) {
    return RawEventDetailsModel(
      id: eventDetails.id,
      transactions: eventDetails.transactions,
      memberRatios: eventDetails.memberRatios,
      team: eventDetails.team,
    );
  }

  RawEventDetailsModel copyWith({
    int? id,
    List<TransactionModel>? transactions,
    List<MemberRatioModel>? memberRatios,
    Team? team,
  }) {
    return RawEventDetailsModel(
      id: id ?? this.id,
      transactions: transactions ?? this.transactions,
      memberRatios: memberRatios ?? this.memberRatios,
      team: team ?? this.team,
    );
  }
}
