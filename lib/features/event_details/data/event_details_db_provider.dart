import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_form.dart';
import 'package:pay_pilot/features/event_details/data/models/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/models/transaction_form.dart';

class EventDetailsDbProvider {
  final EventDao _dbService;
  final MemberDao _memberDao;
  EventDetailsDbProvider(this._dbService, this._memberDao);

  Future<EventDetailsModel> getEvent(int id) async {
    return await _dbService.getEventInfo(id);
  }

  Future<int> insertTransaction(TransactionForm transaction) async {
    return await _dbService.insertTransaction(transaction);
  }

  Future<int> insertRatio(EventRatioForm ratio) async {
    return await _dbService.insertRatio(ratio);
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

  Future<List<Member>> getAllMembers() async {
    return await _memberDao.getAllMembers();
  }
}
