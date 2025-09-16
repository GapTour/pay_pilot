import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';

part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  final ReportDetailsRepository _repository;
  ReportDetailsCubit(this._repository) : super(ReportDetailsInitial());

  void loadReportDetails(int id) async {
    emit(ReportDetailsLoading());

    final reportDetails = await _repository.getReport(id);
    emit(ReportDetailsSuccess(report: reportDetails));
  }
}
