import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';
import 'user_form_screen.dart';
import 'login_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final auth = context.watch<AuthProvider>();

    final isAdmin =
        auth.currentUser != null &&
        auth.currentUser!.role == UserRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          // 🚪 Logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),

      // ➕ เพิ่ม user (admin เท่านั้น)
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserFormScreen(),
                  ),
                );
              },
            )
          : null,

      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (_, i) {
                final u = userProvider.users[i];

                return ListTile(
                  title: Text(
                    '${u.name.firstname} ${u.name.lastname}',
                  ),
                  subtitle: Text(
                    '${u.email} (${u.role.name})',
                  ),

                  // 🗑 ลบ user (admin เท่านั้น)
                  trailing: isAdmin
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ✏️ แก้ไข
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        UserFormScreen(editUser: u),
                                  ),
                                );
                              },
                            ),

                            // 🗑 ลบ
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                userProvider.removeUser(u.id ?? 0);
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
    );
  }
}
