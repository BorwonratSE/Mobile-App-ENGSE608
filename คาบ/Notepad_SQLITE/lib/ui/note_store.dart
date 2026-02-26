import 'package:flutter/material.dart';
import '../../data/models/note.dart';
import '../../data/repositories/note_repository.dart';

class NoteStore extends ChangeNotifier {
  NoteStore(this._repo);

  final NoteRepository _repo;
  List<Note> notes = [];

  Future<void> load() async {
    notes = await _repo.getAll();
    notifyListeners();
  }

  Future<void> add(
    String title,
    String content,
    int? categoryId,
  ) async {
    final now = DateTime.now();
    await _repo.insert(
      Note(
        title: title,
        content: content,
        categoryId: categoryId,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await load();
  }

  Future<void> remove(int id) async {
    await _repo.delete(id);
    await load();
  }
}