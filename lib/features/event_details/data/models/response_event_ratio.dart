class ResponseEventRatio {
  final int id;
  final double ratio;
  final int memberID;

  ResponseEventRatio({
    required this.id,
    required this.ratio,
    required this.memberID,
  });

  factory ResponseEventRatio.fromMap(Map<String, dynamic> map) {
    return ResponseEventRatio(
      id: int.parse(map['id'] as String),
      ratio: double.parse(map['ratio_value'] as String),
      memberID: int.parse(map['member_id'] as String),
    );
  }
}
