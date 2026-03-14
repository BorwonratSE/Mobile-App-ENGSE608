import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository repo = EventRepository();

  List<Event> events = [];
  List<Event> filtered = [];

  String search = "";

  Future loadEvents() async {
    events = await repo.getEvents();
    filter();
  }

  Future addEvent(Event event) async {
    await repo.insertEvent(event);
    await loadEvents();
  }

  Future updateEvent(Event event) async {
    await repo.updateEvent(event);
    await loadEvents();
  }

  Future deleteEvent(int id) async {
    await repo.deleteEvent(id);
    await loadEvents();
  }

  void filter() {
    filtered = events.where((e) {
      return e.title.toLowerCase().contains(search.toLowerCase());
    }).toList();

    notifyListeners();
  }
}
