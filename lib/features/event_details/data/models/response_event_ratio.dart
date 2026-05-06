import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';

class ResponseEventRatio {
  final int id;
  final double ratio;
  final int memberID;

  ResponseEventRatio({
    required this.id,
    required this.ratio,
    required this.memberID,
  });

  factory ResponseEventRatio.fromApi(Map<String, dynamic> map) {
    return ResponseEventRatio(
      id: int.parse(map['id'] as String),
      ratio: double.parse(map['ratio_value'] as String),
      memberID: int.parse(map['member_id'] as String),
    );
  }

  factory ResponseEventRatio.fromParams(EventRatioParams params) {
    return ResponseEventRatio(
      id: params.id!,
      ratio: params.ratioValue,
      memberID: params.memberID,
    );
  }

  factory ResponseEventRatio.fromDb(MemberRatioModel dataModel) {
    return ResponseEventRatio(
      id: dataModel.id,
      ratio: dataModel.ratio,
      memberID: dataModel.member.id,
    );
  }
}
