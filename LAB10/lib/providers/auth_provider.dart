import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  String? token;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username.trim(),
          "password": password.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        token = data['token'];
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        error = "Invalid username or password";
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
