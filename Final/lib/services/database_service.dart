import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/workout.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
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
  }

  Future insertWorkout(Workout workout) async {
    final db = await instance.database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await instance.database;
    final result = await db.query('workouts');
    return result.map((e) => Workout.fromMap(e)).toList();
  }

  Future<int> updateWorkout(Workout workout) async {
    final db = await instance.database;

    return await db.update(
      'workouts',
      workout.toMap(),
      where: 'id=?',
      whereArgs: [workout.id],
    );
  }

  Future deleteWorkout(int id) async {
    final db = await instance.database;

    return await db.delete(
      'workouts',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}