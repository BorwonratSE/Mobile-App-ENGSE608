import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  String? token;
  String? username;

  bool get isAdmin => username == "johnd";

  Future<bool> login(String user, String pass) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": user.trim(),
        "password": pass.trim(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      token = data['token'];
      username = user.trim(); // ⭐ เก็บ username
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      error = "Login failed";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    token = null;
    username = null;
    notifyListeners();
  }
}
