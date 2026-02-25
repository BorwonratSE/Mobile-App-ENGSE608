import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_api_service.dart';

class UserProvider extends ChangeNotifier {
  final UserApiService _api = UserApiService();

  List<UserModel> users = [];
  bool isLoading = false;
  String? error;

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      users = await _api.fetchUsers();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    isLoading = true;
    notifyListeners();

    try {
      final created = await _api.createUser(user);
      users.insert(0, created);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> editUser(int id, UserModel user) async {
    isLoading = true;
    notifyListeners();

    try {
      final updated = await _api.updateUser(id, user);
      final index = users.indexWhere((u) => u.id == id);
      if (index != -1) {
        users[index] = updated;
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> removeUser(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      await _api.deleteUser(id);
      users.removeWhere((u) => u.id == id);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
