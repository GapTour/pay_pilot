import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class ResponseEventDetails {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final ResponseTeam team;
  final List<ResponseEventTransaction> transactions;
  final List<ResponseEventRatio> memberRatios;
  final List<ResponseOrder> orders;

  ResponseEventDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.team,
    required this.transactions,
    required this.memberRatios,
    required this.orders,
  });

  factory ResponseEventDetails.fromApi(Map<String, dynamic> map) {
    return ResponseEventDetails(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      description: map['description'] as String?,
      date: DateTime.parse(map['event_date'] as String),
      team: ResponseTeam.fromApi(map['team'] as Map<String, dynamic>),
      transactions: map['transactions'] != null
          ? (map['transactions'] as List<dynamic>)
                .map(
                  (e) => ResponseEventTransaction.fromApi(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : [],
      memberRatios: map['ratios'] != null
          ? (map['ratios'] as List<dynamic>)
                .map(
                  (e) => ResponseEventRatio.fromApi(e as Map<String, dynamic>),
                )
                .toList()
          : [],
      orders: map['orders'] != null
          ? (map['orders'] as List<dynamic>)
                .map((e) => ResponseOrder.fromApi(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  ResponseEventDetails copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    ResponseTeam? team,
    List<ResponseEventTransaction>? transactions,
    List<ResponseEventRatio>? memberRatios,
    List<ResponseOrder>? orders,
  }) {
    return ResponseEventDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      team: team ?? this.team,
      transactions: transactions ?? this.transactions,
      memberRatios: memberRatios ?? this.memberRatios,
      orders: orders ?? this.orders,
    );
  }
}
