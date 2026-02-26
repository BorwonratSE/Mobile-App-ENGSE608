import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/note.dart';

class NoteRepository {
  // ดึงโน้ตทั้งหมด
  Future<List<Note>> getAll() async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      'notes',
      orderBy: 'updated_at DESC',
    );
    return rows.map(Note.fromMap).toList();
  }

  // เพิ่มโน้ต
  Future<void> insert(Note note) async {
    final db = await AppDatabase.instance.database;
    await db.insert(
      'notes',
      note.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ลบโน้ต
  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}