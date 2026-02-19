import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserApiService {
  static const String baseUrl = 'https://fakestoreapi.com/users';

  // 🔹 GET users
  Future<List<UserModel>> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // 🔹 POST add user
  Future<void> addUser(UserModel user) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  // 🔹 PUT update user
  Future<void> updateUser(UserModel user) async {
    if (user.id == null) return;

    final res = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  // 🔹 DELETE user
  Future<void> deleteUser(int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
