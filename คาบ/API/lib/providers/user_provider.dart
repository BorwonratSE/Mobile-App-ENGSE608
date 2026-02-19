import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_api_service.dart';

class UserProvider extends ChangeNotifier {
  final UserApiService _api = UserApiService();

  List<UserModel> users = [];
  bool isLoading = false;
  String? error;

  Future<void> loadUsers() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      // ✅ โหลด user จาก API จริง
      users = await _api.getUsers();

      // ⭐⭐⭐ เพิ่ม admin ถ้ายังไม่มี ⭐⭐⭐
      final hasAdmin = users.any((u) => u.username == 'admin');

      if (!hasAdmin) {
        users.insert(
          0,
          UserModel(
            id: 0,
            email: 'admin@system.com',
            username: 'admin',
            password: 'root',
            phone: '',
            role: UserRole.admin, // ✅ admin
            name: NameModel(
              firstname: 'System',
              lastname: 'Admin',
            ),
            address: AddressModel(
              city: '',
              street: '',
              number: 0,
              zipcode: '',
              geolocation: GeoLocationModel(
                lat: '',
                long: '',
              ),
            ),
          ),
        );
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ➕ เพิ่ม user
  Future<void> addUser(UserModel user) async {
    try {
      await _api.addUser(user);
      users.add(user);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // ✏️ แก้ไข user
  Future<void> updateUser(UserModel user) async {
    try {
      await _api.updateUser(user);
      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = user;
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // 🗑 ลบ user
  Future<void> removeUser(int id) async {
    try {
      await _api.deleteUser(id);
      users.removeWhere((u) => u.id == id);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
