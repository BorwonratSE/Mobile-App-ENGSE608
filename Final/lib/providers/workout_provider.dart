import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/database_service.dart';

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _workouts = [];

  String search = "";
  String filterType = "All";
  String sortBy = "date";

  List<Workout> get workouts {
    List<Workout> filtered = _workouts.where((w) {
      final matchSearch =
          w.activity.toLowerCase().contains(search.toLowerCase());

      final matchType = filterType == "All" || w.type == filterType;

      return matchSearch && matchType;
    }).toList();

    // SORTING
    if (sortBy == "name") {
      filtered.sort((a, b) => a.activity.compareTo(b.activity));
    } else if (sortBy == "duration") {
      filtered.sort((a, b) => b.duration.compareTo(a.duration));
    } else if (sortBy == "date") {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    }

    return filtered;
  }

  Future loadWorkouts() async {
    _workouts = await DatabaseService.instance.getWorkouts();
    notifyListeners();
  }

  Future addWorkout(Workout workout) async {
    await DatabaseService.instance.insertWorkout(workout);
    await loadWorkouts();
  }

  Future updateWorkout(Workout workout) async {
    await DatabaseService.instance.updateWorkout(workout);
    await loadWorkouts();
  }

  Future deleteWorkout(int id) async {
    await DatabaseService.instance.deleteWorkout(id);
    await loadWorkouts();
  }

  int get total => _workouts.length;

  int countType(String type) {
    return _workouts.where((w) => w.type == type).length;
  }
}