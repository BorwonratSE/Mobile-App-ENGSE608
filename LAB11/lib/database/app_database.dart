import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'activity.db');

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE categories(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  color INTEGER
)
''');

    await db.execute('''
CREATE TABLE events(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  description TEXT,
  startTime TEXT,
  endTime TEXT,
  status TEXT,
  categoryId INTEGER,
  updatedAt TEXT,
  FOREIGN KEY(categoryId) REFERENCES categories(id)
)
''');

    await db.execute('''
CREATE TABLE reminders(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  eventId INTEGER,
  remindAt TEXT,
  active INTEGER,
  FOREIGN KEY(eventId) REFERENCES events(id)
)
''');

    // Default categories
    await db.insert("categories", {"name": "Meeting", "color": 0xFF2196F3});
    await db.insert("categories", {"name": "Training", "color": 0xFF4CAF50});
    await db.insert("categories", {
      "name": "External Task",
      "color": 0xFFFF9800,
    });
    await db.insert("categories", {
      "name": "Document Work",
      "color": 0xFF9C27B0,
    });
  }
}
