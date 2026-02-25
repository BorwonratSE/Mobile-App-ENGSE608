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
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final u = widget.editUser;
    if (u != null) {
      emailCtrl.text = u.email;
      usernameCtrl.text = u.username;
      passwordCtrl.text = u.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isEdit = widget.editUser != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit User' : 'Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        final user = UserModel(
                          id: widget.editUser?.id,
                          email: emailCtrl.text,
                          username: usernameCtrl.text,
                          password: passwordCtrl.text,
                          phone: '',
                          name: NameModel(firstname: '', lastname: ''),
                          address: AddressModel(
                            city: '',
                            street: '',
                            number: 0,
                            zipcode: '',
                            geolocation: GeoLocationModel(lat: '', long: ''),
                          ),
                        );

                        if (isEdit) {
                          await provider.editUser(widget.editUser!.id!, user);
                        } else {
                          await provider.addUser(user);
                        }

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: Text(isEdit ? 'Save' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
