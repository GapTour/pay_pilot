import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/event_details/data/event_details_db_provider.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_form.dart';

class EventDetailsRepository {
  final EventDetailsDbProvider _dbProvider;

  EventDetailsRepository(this._dbProvider);

  Future<EventDetailsModel> getEvent(int id) async {
    return await _dbProvider.getEvent(id);
  }

  Future<int> insertTransaction(TransactionForm transaction) async {
    return await _dbProvider.insertTransaction(transaction);
  }

  Future<int> insertRatio(EventRatioForm ratio) async {
    return await _dbProvider.insertRatio(ratio);
  }

  Future<void> updateTransaction(TransactionEditForm transaction) async {
    await _dbProvider.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(int transaction) async {
    await _dbProvider.deleteTransaction(transaction);
  }

  Future<void> updateEventRatio(EventRatioEditForm eventRatio) async {
    await _dbProvider.updateEventRatio(eventRatio);
  }

  Future<void> deleteEventRatio(int ratioID) async {
    await _dbProvider.deleteEventRatio(ratioID);
  }

  Future<List<Member>> getAllMembers() async {
    return await _dbProvider.getAllMembers();
  }
}
