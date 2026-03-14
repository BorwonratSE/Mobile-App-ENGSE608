import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository repo = CategoryRepository();

  List<Category> categories = [];

  Future loadCategories() async {
    categories = await repo.getCategories();

    notifyListeners();
  }

  Future addCategory(Category category) async {
    await repo.insertCategory(category);

    await loadCategories();
  }
}
