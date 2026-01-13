import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/reports/data/models/response_report.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportRepository _repository;
  ReportsCubit(this._repository)
    : super(ReportsState(reportsStatus: ReportsStatus.initial, reports: []));

  void loadReports() async {
    emit(state.copyWith(reportsStatus: ReportsStatus.loading));

    final dataState = await _repository.getAllReports();

    if (dataState is DataSuccess) {
      final reports = dataState.data!;
      reports.sort((a, b) => b.generateFor.compareTo(a.generateFor));

      emit(
        state.copyWith(reportsStatus: ReportsStatus.success, reports: reports),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(reportsStatus: ReportsStatus.failure));
    }
  }

  void addReport(ReportParams params) async {
    emit(state.copyWith(reportsStatus: ReportsStatus.loading));

    final dataState = await _repository.createReport(params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          reportsStatus: ReportsStatus.success,
          reports: state.reports
            ..add(dataState.data!)
            ..sort((a, b) => b.generateFor.compareTo(a.generateFor)),
        ),
      );
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(reportsStatus: ReportsStatus.failure));
    }
  }

  // void updateReport(ReportForm report) async {
  //   await _repository.updateReport(report).whenComplete(() {
  //     loadReports();
  //   });
  // }

  void deleteReport(int reportID) async {
    emit(state.copyWith(reportsStatus: ReportsStatus.loading));

    final dataState = await _repository.deleteReport(reportID);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          reportsStatus: ReportsStatus.success,
          reports: state.reports
            ..removeWhere((element) => element.id == reportID),
        ),
      );
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(reportsStatus: ReportsStatus.failure));
    }
  }
}
