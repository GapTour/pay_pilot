import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/params/event_story_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/event_stories.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_story.dart';

part 'event_stories_dao.g.dart';

@DriftAccessor(tables: [EventStories])
class EventStoriesDao extends DatabaseAccessor<AppDatabase>
    with _$EventStoriesDaoMixin {
  EventStoriesDao(super.db);

  Future<int> insertStory(EventStoryParams eventStory) async {
    return await db
        .into(eventStories)
        .insert(
          EventStoriesCompanion(
            encodedText: Value(eventStory.encodedText),
            eventID: Value(eventStory.eventID),
            title: Value(eventStory.title),
          ),
        );
  }

  Future<ResponseEventStory> updateStory(EventStoryParams eventStory) async {
    await (db.update(
      eventStories,
    )..where((tbl) => tbl.id.equals(eventStory.id!))).write(
      EventStoriesCompanion(
        encodedText: Value(eventStory.encodedText),
        eventID: Value(eventStory.eventID),
        title: Value(eventStory.title),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );

    return ResponseEventStory(
      id: eventStory.id!,
      title: eventStory.title,
      encodedText: eventStory.encodedText,
      updateAt: DateTime.now().toUtc(),
      createAt: eventStory.createAt,
    );
  }

  Future<void> deleteStory(int id) async {
    await (db.delete(eventStories)..where((tbl) => tbl.id.equals(id))).go();
  }
}
