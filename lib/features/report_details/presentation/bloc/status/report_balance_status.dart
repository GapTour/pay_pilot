part of '../report_details_bloc.dart';

sealed class ReportBalanceStatus extends Equatable {}

class ReportBalanceInit extends ReportBalanceStatus {
  @override
  List<Object?> get props => [];
}

class ReportBalanceLoading extends ReportBalanceStatus {
  @override
  List<Object?> get props => [];
}

class ReportBalanceCalculated extends ReportBalanceStatus {
  final List<ResponseEventBalance> membersBalance;

  ReportBalanceCalculated({required this.membersBalance});

  @override
  List<Object?> get props => [membersBalance];
}

class ReportBalanceFailure extends ReportBalanceStatus {
  @override
  List<Object?> get props => [];
}
