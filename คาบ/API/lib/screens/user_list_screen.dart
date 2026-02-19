import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() =>
      _UserListScreenState();
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
    final p = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
  title: const Text('Users'),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        context.read<UserProvider>().logout();
        Navigator.pushReplacementNamed(context, '/login');
      },
    ),
  ],
),

      body: p.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: p.users.length,
              itemBuilder: (_, i) {
                final u = p.users[i];
                return ListTile(
                  title: Text(
                      '${u.name.firstname} ${u.name.lastname}'),
                  subtitle: Text(u.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        p.removeUser(u.id!),
                  ),
                );
              },
            ),
    );
  }
}
