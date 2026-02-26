import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_form_page.dart';
import 'state/note_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteStore>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<NoteStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteFormPage()),
          );
        },
      ),
      body: store.loading
          ? const Center(child: CircularProgressIndicator())
          : store.notes.isEmpty
              ? const Center(child: Text('ยังไม่มีโน้ต'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: store.notes.length,
                  itemBuilder: (_, i) {
                    final n = store.notes[i];
                    return Card(
                      child: ListTile(
                        title: Text(n.title),
                        subtitle: Text(
                          n.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.remove(n.id!),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NoteFormPage(
                                noteId: n.id,
                                title: n.title,
                                content: n.content,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}