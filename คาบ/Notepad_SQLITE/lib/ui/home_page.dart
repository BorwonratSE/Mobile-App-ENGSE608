import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/note_store.dart';
import 'note_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteStore>().load();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<NoteStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: store.notes.isEmpty
          ? const Center(child: Text('ยังไม่มีโน้ต'))
          : ListView.builder(
              itemCount: store.notes.length,
              itemBuilder: (context, index) {
                final n = store.notes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(n.title),
                    subtitle: Text(n.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          store.remove(n.id!),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoteFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}