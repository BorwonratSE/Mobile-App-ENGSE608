import 'package:flutter/material.dart';
import '../../data/models/note.dart';
import '../../data/repositories/note_repository.dart';

class NoteStore extends ChangeNotifier {
  NoteStore(this._repo);

  final NoteRepository _repo;

  bool loading = false;
  List<Note> notes = [];

  Future<void> load() async {
    loading = true;
    notifyListeners();
    notes = await _repo.getAllNotes();
    loading = false;
    notifyListeners();
  }

  Future<void> add(String title, String content) async {
    final now = DateTime.now();
    await _repo.insertNote(
      Note(
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await load();
  }

  Future<void> edit(int id, String title, String content) async {
    final existing = await _repo.getNoteById(id);
    if (existing == null) return;

    await _repo.updateNote(
      existing.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      ),
    );
    await load();
  }

  Future<void> remove(int id) async {
    await _repo.deleteNote(id);
    await load();
  }

  Future<void> clear() async {
    await _repo.deleteAll();
    notes = [];
    notifyListeners();
  }
}