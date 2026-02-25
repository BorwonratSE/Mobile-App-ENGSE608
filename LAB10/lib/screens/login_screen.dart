import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      final success = await auth.login(
                        userCtrl.text,
                        passCtrl.text,
                      );

                      if (success && context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductListScreen(),
                          ),
                        );
                      }
                    },
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
            if (auth.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  auth.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}
