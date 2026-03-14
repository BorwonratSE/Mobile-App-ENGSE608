import '../database/app_database.dart';
import '../models/reminder_model.dart';

class ReminderRepository {
  Future<List<Reminder>> getReminders(int eventId) async {
    final db = await AppDatabase.database;

    final result = await db.query(
      "reminders",
      where: "eventId=?",
      whereArgs: [eventId],
    );

    return result.map((e) => Reminder.fromMap(e)).toList();
  }

  Future<void> insertReminder(Reminder reminder) async {
    final db = await AppDatabase.database;

    await db.insert("reminders", reminder.toMap());
  }

  Future<void> deactivateReminders(int eventId) async {
    final db = await AppDatabase.database;

    await db.update(
      "reminders",
      {"active": 0},
      where: "eventId=?",
      whereArgs: [eventId],
    );
  }
}
