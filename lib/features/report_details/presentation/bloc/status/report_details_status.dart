part of '../report_details_bloc.dart';

sealed class ReportDetailsStatus extends Equatable {}

class ReportDetailsInit extends ReportDetailsStatus {
  @override
  List<Object?> get props => [];
}

class ReportDetailsLoading extends ReportDetailsStatus {
  @override
  List<Object?> get props => [];
}

class ReportDetailsFetched extends ReportDetailsStatus {
  final ResponseReportDetails reportDetails;

  ReportDetailsFetched({required this.reportDetails});

  @override
  List<Object?> get props => [reportDetails];
}

class ReportDetailsFailure extends ReportDetailsStatus {
  @override
  List<Object?> get props => [];
}
