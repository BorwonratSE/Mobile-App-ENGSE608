import '../database/app_database.dart';
import '../models/event_model.dart';

class EventRepository {
  Future<List<Event>> getEvents() async {
    final db = await AppDatabase.database;

    final result = await db.query("events");

    return result.map((e) => Event.fromMap(e)).toList();
  }

  Future insertEvent(Event event) async {
    final db = await AppDatabase.database;

    await db.insert("events", event.toMap());
  }

  Future updateEvent(Event event) async {
    final db = await AppDatabase.database;

    await db.update(
      "events",
      event.toMap(),
      where: "id=?",
      whereArgs: [event.id],
    );
  }

  Future deleteEvent(int id) async {
    final db = await AppDatabase.database;

    await db.delete("events", where: "id=?", whereArgs: [id]);
  }
}
