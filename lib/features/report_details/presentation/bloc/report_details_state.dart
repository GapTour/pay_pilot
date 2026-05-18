part of 'report_details_bloc.dart';

class ReportDetailsState extends Equatable {
  final ReportBalanceStatus reportBalanceStatus;
  final ReportDetailsStatus reportDetailsStatus;
  const ReportDetailsState({
    required this.reportBalanceStatus,
    required this.reportDetailsStatus,
  });

  @override
  List<Object> get props => [reportBalanceStatus, reportDetailsStatus];

  ReportDetailsState copyWith({
    ReportBalanceStatus? reportBalanceStatus,
    ReportDetailsStatus? reportDetailsStatus,
  }) {
    return ReportDetailsState(
      reportBalanceStatus: reportBalanceStatus ?? this.reportBalanceStatus,
      reportDetailsStatus: reportDetailsStatus ?? this.reportDetailsStatus,
    );
  }
}
