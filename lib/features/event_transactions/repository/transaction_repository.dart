import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_db_provider.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_form.dart';

class TransactionRepository {
  final TransactionDbProvider _dbProvider;

  TransactionRepository(this._dbProvider);

  Future<EventDetailsModel> getEvent(int id) async {
    return await _dbProvider.getEvent(id);
  }

  Future<int> insertTransaction(TransactionForm transaction) async {
    return await _dbProvider.insertTransaction(transaction);
  }

  Future<void> updateTransaction(TransactionEditForm transaction) async {
    await _dbProvider.updateTransaction(transaction);
  }
}
