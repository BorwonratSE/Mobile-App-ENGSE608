import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  final UserModel? editUser;

  const UserFormScreen({super.key, this.editUser});
  
  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _emailCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final user = UserModel(
                    email: _emailCtrl.text.trim(),
                    username: _usernameCtrl.text.trim(),
                    password: _passwordCtrl.text,
                    phone: '',

                    // ✅ กำหนดสิทธิ์เริ่มต้น
                    role: UserRole.user,

                    name: NameModel(
                      firstname: 'John',
                      lastname: 'Doe',
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
                  );

                  context.read<UserProvider>().addUser(user);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
