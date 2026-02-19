import 'package:flutter/material.dart';
import '../services/user_api_service.dart';

class UserProvider extends ChangeNotifier {
  final UserApiService _api = UserApiService();

  bool isLoading = false;
  String? error;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final users = await _api.fetchUsers();

      users.firstWhere(
        (u) => u['username'] == username && u['password'] == password,
      );

      return true;
    } catch (e) {
      error = 'Invalid username or password';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
