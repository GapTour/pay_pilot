import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';

class EventDbProvider {
  final EventDao _dbService;
  final TeamDao _teamDao;
  EventDbProvider(this._dbService, this._teamDao);

  Future<List<EventModel>> getAllEvents() async {
    return await _dbService.getAllEvents();
  }

  Future<List<Team>> getAllTeams() async {
    return await _teamDao.getAllTeams();
  }

  Future<int> insertEvent(EventParams event) async {
    return await _dbService.insertEvent(event);
  }

  Future<void> updateEvent(EventParams event) async {
    await _dbService.updateEvent(event);
  }

  Future<void> deleteEvent(int event) async {
    await _dbService.deleteEvent(event);
  }
}
