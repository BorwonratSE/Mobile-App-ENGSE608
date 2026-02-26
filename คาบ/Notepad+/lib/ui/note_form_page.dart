import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/note_store.dart';

class NoteFormPage extends StatefulWidget {
  final int? noteId;
  final String? title;
  final String? content;

  const NoteFormPage({
    super.key,
    this.noteId,
    this.title,
    this.content,
  });

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleCtl;
  late final TextEditingController contentCtl;

  @override
  void initState() {
    super.initState();
    titleCtl = TextEditingController(text: widget.title ?? '');
    contentCtl = TextEditingController(text: widget.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<NoteStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId == null ? 'เพิ่มโน้ต' : 'แก้ไขโน้ต'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtl,
                decoration: _dec('หัวข้อ'),
                validator: (v) =>
                    v!.isEmpty ? 'กรุณากรอกหัวข้อ' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: contentCtl,
                decoration: _dec('รายละเอียด'),
                minLines: 4,
                maxLines: 8,
                validator: (v) =>
                    v!.isEmpty ? 'กรุณากรอกรายละเอียด' : null,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('บันทึก'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  if (widget.noteId == null) {
                    store.add(
                        titleCtl.text, contentCtl.text);
                  } else {
                    store.edit(
                        widget.noteId!,
                        titleCtl.text,
                        contentCtl.text);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.indigo.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );
}