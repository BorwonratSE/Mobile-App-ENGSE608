import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/note_store.dart';
import 'state/category_store.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleCtl = TextEditingController();
  final contentCtl = TextEditingController();
  int? categoryId;

  @override
  void initState() {
    super.initState();
    context.read<CategoryStore>().load();
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        context.watch<CategoryStore>().categories;

    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มโน้ต')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtl,
              decoration: const InputDecoration(
                labelText: 'หัวข้อ',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentCtl,
              decoration: const InputDecoration(
                labelText: 'เนื้อหา',
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: categoryId,
              items: categories
                  .map(
                    (c) => DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() {
                  categoryId = v;
                });
              },
              decoration: const InputDecoration(
                labelText: 'หมวดหมู่',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                await context.read<NoteStore>().add(
                      titleCtl.text,
                      contentCtl.text,
                      categoryId,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}