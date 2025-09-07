import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/services/db_service.dart';
import 'package:pay_pilot/features/incomes/data/income_form.dart';

class IncomeDbProvider {
  final DatabaseService _dbService;
  IncomeDbProvider(this._dbService);

  Future<List<Income>> getAllIncomes() async {
    return await _dbService.getAllIncomes();
  }

  Future<int> insertIncome(IncomeForm income) async {
    return await _dbService.insertIncome(income);
  }

  Future<void> updateIncome(IncomeForm income) async {
    await _dbService.updateIncome(income);
  }
}
