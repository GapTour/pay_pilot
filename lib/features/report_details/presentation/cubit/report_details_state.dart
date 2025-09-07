part of 'report_details_cubit.dart';

sealed class ReportDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ReportDetailsInitial extends ReportDetailsState {}

final class ReportDetailsLoading extends ReportDetailsState {}

final class ReportDetailsSuccess extends ReportDetailsState {
  final Report report;
  ReportDetailsSuccess({required this.report});

  @override
  List<Object> get props => [report];
}

final class ReportDetailsFailure extends ReportDetailsState {}
