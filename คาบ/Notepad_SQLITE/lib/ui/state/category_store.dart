import 'package:flutter/material.dart';
import '../../data/models/category.dart';
import '../../data/repositories/category_repository.dart';

class CategoryStore extends ChangeNotifier {
  CategoryStore(this._repo);

  final CategoryRepository _repo;
  List<Category> categories = [];

  Future<void> load() async {
    categories = await _repo.getAll();
    notifyListeners();
  }
}