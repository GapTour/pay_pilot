part of 'reports_cubit.dart';

enum ReportsStatus { initial, loading, success, failure }

class ReportsState extends Equatable {
  final ReportsStatus reportsStatus;
  final List<Report> reports;
  const ReportsState({required this.reportsStatus, required this.reports});

  @override
  List<Object> get props => [reportsStatus, reports];

  ReportsState copyWith({ReportsStatus? reportsStatus, List<Report>? reports}) {
    return ReportsState(
      reportsStatus: reportsStatus ?? this.reportsStatus,
      reports: reports ?? this.reports,
    );
  }
}
