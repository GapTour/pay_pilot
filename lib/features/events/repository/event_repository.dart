import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/events/data/event_db_provider.dart';
import 'package:pay_pilot/features/events/data/event_edit_form.dart';
import 'package:pay_pilot/features/events/data/event_form.dart';

class EventRepository {
  final EventDbProvider _dbProvider;

  EventRepository(this._dbProvider);

  Future<List<EventModel>> getAllEvents() async {
    return await _dbProvider.getAllEvents();
  }

  Future<List<Team>> getAllTeams() async {
    return await _dbProvider.getAllTeams();
  }

  Future<int> insertEvent(EventForm event) async {
    return await _dbProvider.insertEvent(event);
  }

  Future<void> updateEvent(EventEditForm event) async {
    await _dbProvider.updateEvent(event);
  }

  Future<void> deleteEvent(int event) async {
    await _dbProvider.deleteEvent(event);
  }
}
