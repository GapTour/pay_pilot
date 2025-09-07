import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportRepository _repository;
  ReportsCubit(this._repository)
    : super(ReportsState(reportsStatus: ReportsStatus.initial, reports: []));

  void loadReports() async {
    emit(state.copyWith(reportsStatus: ReportsStatus.loading));
    try {
      final reports = await _repository.getAllReports();
      emit(
        state.copyWith(reportsStatus: ReportsStatus.success, reports: reports),
      );
    } catch (_) {
      emit(state.copyWith(reportsStatus: ReportsStatus.failure));
    }
  }

  void addReport(ReportForm report) async {
    await _repository.insertReport(report).whenComplete(() {
      loadReports();
    });
  }

  void updateReport(ReportForm report) async {
    await _repository.updateReport(report).whenComplete(() {
      loadReports();
    });
  }
}
