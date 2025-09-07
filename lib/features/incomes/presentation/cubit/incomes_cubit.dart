import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/incomes/data/income_form.dart';
import 'package:pay_pilot/features/incomes/repository/income_repository.dart';

part 'incomes_state.dart';

class IncomesCubit extends Cubit<IncomesState> {
  final IncomeRepository _repository;
  IncomesCubit(this._repository)
    : super(IncomesState(incomesStatus: IncomesStatus.initial, incomes: []));

  void loadIncomes() async {
    emit(state.copyWith(incomesStatus: IncomesStatus.loading));

    try {
      final incomes = await _repository.getAllIncomes();
      incomes.sort((a, b) => b.date.compareTo(a.date));

      emit(
        state.copyWith(incomesStatus: IncomesStatus.success, incomes: incomes),
      );
    } catch (_) {
      emit(state.copyWith(incomesStatus: IncomesStatus.failure));
    }
  }

  void addIncome(IncomeForm income) async {
    await _repository.insertIncome(income).whenComplete(() {
      loadIncomes();
    });
  }

  void updateIncome(IncomeForm income) async {
    await _repository.updateIncome(income).whenComplete(() {
      loadIncomes();
    });
  }
}
