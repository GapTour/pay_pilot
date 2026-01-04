class EventRatioParams {
  final int? id;
  final double ratioValue;
  final int memberID;
  final int eventID;

  EventRatioParams({
    required this.id,
    required this.ratioValue,
    required this.memberID,
    required this.eventID,
  });

  Map<String, dynamic> toMap() {
    return {
      'ratio_value': ratioValue,
      'member_id': memberID,
      'event_id': eventID,
    };
  }
}
