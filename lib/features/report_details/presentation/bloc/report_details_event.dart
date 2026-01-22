part of 'report_details_bloc.dart';

sealed class ReportDetailsEvent extends Equatable {
  const ReportDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchReportDetails extends ReportDetailsEvent {
  final int reportID;

  const FetchReportDetails({required this.reportID});
}

class CalculateMembersBalance extends ReportDetailsEvent {}
