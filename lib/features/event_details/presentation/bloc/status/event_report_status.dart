part of '../event_details_bloc.dart';

class EventReportStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventReportInitial extends EventReportStatus {}

class EventReportLoading extends EventReportStatus {}

class EventReportSuccess extends EventReportStatus {
  final List<ResponseEventBalance> membersBalance;

  EventReportSuccess(this.membersBalance);

  @override
  List<Object?> get props => [membersBalance];
}

class EventReportFailure extends EventReportStatus {}
