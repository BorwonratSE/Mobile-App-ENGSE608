import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/workout.dart';

class DatabaseService {

  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'workout.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {

    // ===== ตารางประเภท =====
    await db.execute('''
CREATE TABLE workout_types(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
)
''');

    // ===== ตารางกิจกรรม =====
    await db.execute('''
CREATE TABLE workouts(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  activity TEXT,
  type TEXT,
  duration INTEGER,
  calories INTEGER,
  date TEXT,
  note TEXT
)
''');

    // ===== เพิ่มประเภทเริ่มต้น =====
    await db.insert('workout_types', {'name': 'Cardio'});
    await db.insert('workout_types', {'name': 'Strength'});
    await db.insert('workout_types', {'name': 'Flexibility'});
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final result = await db.query('workouts');
    return result.map((e) => Workout.fromMap(e)).toList();
  }

  Future insertWorkout(Workout workout) async {
    final db = await database;
    await db.insert('workouts', workout.toMap());
  }

  Future updateWorkout(Workout workout) async {
    final db = await database;

    await db.update(
      'workouts',
      workout.toMap(),
      where: 'id=?',
      whereArgs: [workout.id],
    );
  }

  Future deleteWorkout(int id) async {
    final db = await database;

    await db.delete(
      'workouts',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}