import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import 'user_form_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  String? error;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UserProvider>().loadUsers();
    });
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Text(
              'เข้าสู่ระบบ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],

            const SizedBox(height: 24),

            // 🔐 Login
            ElevatedButton(
              onPressed: userProvider.isLoading
                  ? null
                  : () {
                      try {
                        final user = userProvider.users.firstWhere(
                          (u) =>
                              u.username == usernameCtrl.text.trim() &&
                              u.password == passwordCtrl.text.trim(),
                        );

                        authProvider.login(user);

                        Navigator.pushReplacementNamed(
                          context,
                          '/users',
                        );
                      } catch (e) {
                        setState(() {
                          error = 'Username หรือ Password ไม่ถูกต้อง';
                        });
                      }
                    },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Login'),
              ),
            ),

            const SizedBox(height: 12),

            // 📝 สมัครสมาชิก
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserFormScreen(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('สมัครสมาชิก'),
              ),
            ),

            if (userProvider.isLoading) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
