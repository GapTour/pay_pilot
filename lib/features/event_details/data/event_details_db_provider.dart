import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_form.dart';

class EventDetailsDbProvider {
  final EventDao _dbService;
  EventDetailsDbProvider(this._dbService);

  Future<EventDetailsModel> getEvent(int id) async {
    return await _dbService.getEventInfo(id);
  }

  Future<int> insertTransaction(TransactionForm transaction) async {
    return await _dbService.insertTransaction(transaction);
  }

  Future<void> updateTransaction(TransactionEditForm transaction) async {
    await _dbService.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(int transaction) async {
    await _dbService.deleteTransaction(transaction);
  }

  Future<void> updateEventRatio(EventRatioEditForm eventRatio) async {
    await _dbService.updateRatio(eventRatio);
  }

  Future<void> deleteEventRatio(int ratioID) async {
    await _dbService.deleteRatio(ratioID);
  }
}
