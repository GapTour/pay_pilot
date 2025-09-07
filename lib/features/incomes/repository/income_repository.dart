import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/incomes/data/income_db_provider.dart';
import 'package:pay_pilot/features/incomes/data/income_form.dart';

class IncomeRepository {
  final IncomeDbProvider _dbProvider;
  IncomeRepository(this._dbProvider);

  Future<List<Income>> getAllIncomes() async {
    return await _dbProvider.getAllIncomes();
  }

  Future<int> insertIncome(IncomeForm income) async {
    return await _dbProvider.insertIncome(income);
  }

  Future<void> updateIncome(IncomeForm income) async {
    await _dbProvider.updateIncome(income);
  }
}
