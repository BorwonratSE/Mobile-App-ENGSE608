import '../database/app_database.dart';
import '../models/category_model.dart';

class CategoryRepository {
  Future<List<Category>> getCategories() async {
    final db = await AppDatabase.database;

    final result = await db.query("categories");

    return result.map((e) => Category.fromMap(e)).toList();
  }

  Future<void> insertCategory(Category category) async {
    final db = await AppDatabase.database;

    await db.insert("categories", category.toMap());
  }

  Future<void> deleteCategory(int id) async {
    final db = await AppDatabase.database;

    final events = await db.query(
      "events",
      where: "categoryId=?",
      whereArgs: [id],
    );

    if (events.isNotEmpty) {
      throw Exception("Category is used by events");
    }

    await db.delete("categories", where: "id=?", whereArgs: [id]);
  }
}
