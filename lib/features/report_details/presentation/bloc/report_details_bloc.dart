import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_balance.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';

part 'report_details_event.dart';
part 'report_details_state.dart';
part 'status/report_balance_status.dart';
part 'status/report_details_status.dart';

class ReportDetailsBloc extends Bloc<ReportDetailsEvent, ReportDetailsState> {
  final ReportDetailsRepository _repository;
  ReportDetailsBloc(this._repository)
    : super(
        ReportDetailsState(
          reportBalanceStatus: ReportBalanceInit(),
          reportDetailsStatus: ReportDetailsInit(),
        ),
      ) {
    on<FetchReportDetails>(_fetchReportDetails);
    on<CalculateMembersBalance>(_calculateMembersBalance);
  }

  Future<void> _fetchReportDetails(
    FetchReportDetails event,
    Emitter<ReportDetailsState> emit,
  ) async {
    emit(state.copyWith(reportDetailsStatus: ReportDetailsLoading()));

    final dataState = await _repository.getReportDetails(event.reportID);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          reportDetailsStatus: ReportDetailsFetched(
            reportDetails: dataState.data!,
          ),
        ),
      );
      add(CalculateMembersBalance());
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(reportDetailsStatus: ReportDetailsFailure()));
    }
  }

  Future<void> _calculateMembersBalance(
    CalculateMembersBalance event,
    Emitter<ReportDetailsState> emit,
  ) async {
    emit(state.copyWith(reportBalanceStatus: ReportBalanceLoading()));

    final dataState = await _repository.getAllMembers();

    if (dataState is DataSuccess) {
      final membersBalance = await CalculatorHelper.customTotalSalaries(
        events: (state.reportDetailsStatus as ReportDetailsFetched)
            .reportDetails
            .events,
        members: dataState.data!,
      );
      emit(
        state.copyWith(
          reportBalanceStatus: ReportBalanceCalculated(
            membersBalance: membersBalance,
          ),
        ),
      );
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(reportBalanceStatus: ReportBalanceFailure()));
    }
  }
}
