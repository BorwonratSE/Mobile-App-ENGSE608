import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../providers/category_provider.dart';
import '../models/category_model.dart';

class AddEditEventScreen extends StatefulWidget {
  final Event? event;

  const AddEditEventScreen({super.key, this.event});

  @override
  State<AddEditEventScreen> createState() => _AddEditEventScreenState();
}

class _AddEditEventScreenState extends State<AddEditEventScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      titleController.text = widget.event!.title;
      descController.text = widget.event!.description;

      start = widget.event!.startTime;
      end = widget.event!.endTime;

      selectedCategoryId = widget.event!.categoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    List<Category> categories = categoryProvider.categories;

    if (selectedCategoryId == null && categories.isNotEmpty) {
      selectedCategoryId = categories.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? "Add Event" : "Edit Event"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 20),

            /// Category Dropdown
            DropdownButtonFormField<int>(
              value: selectedCategoryId,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        color: Color(category.color),
                      ),

                      const SizedBox(width: 10),

                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategoryId = value;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Save"),
              onPressed: () async {
                final event = Event(
                  id: widget.event?.id,
                  title: titleController.text,
                  description: descController.text,
                  startTime: start,
                  endTime: end,
                  status: "pending",
                  categoryId: selectedCategoryId!,
                  updatedAt: DateTime.now(),
                );

                if (widget.event == null) {
                  await eventProvider.addEvent(event);
                } else {
                  await eventProvider.updateEvent(event);
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
