import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../providers/category_provider.dart';
import '../models/category_model.dart';
import 'add_edit_event_screen.dart';

class ActivityListScreen extends StatelessWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Activity Tracker")),

      body: Column(
        children: [
          /// Search
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search activity",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                eventProvider.search = value;
                eventProvider.filter();
              },
            ),
          ),

          /// Event List
          Expanded(
            child: ListView.builder(
              itemCount: eventProvider.filtered.length,
              itemBuilder: (context, index) {
                final event = eventProvider.filtered[index];

                /// หา category ของ event
                Category? category;

                try {
                  category = categoryProvider.categories.firstWhere(
                    (c) => c.id == event.categoryId,
                  );
                } catch (e) {
                  category = null;
                }

                Color indicatorColor = category != null
                    ? Color(category.color)
                    : Colors.grey;

                return Card(
                  child: ListTile(
                    /// Category color indicator
                    leading: Container(
                      width: 10,
                      height: 40,
                      color: indicatorColor,
                    ),

                    title: Text(event.title),

                    subtitle: Text("${event.startTime} - ${event.endTime}"),

                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "edit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditEventScreen(event: event),
                            ),
                          );
                        }

                        if (value == "delete") {
                          eventProvider.deleteEvent(event.id!);
                        }
                      },

                      itemBuilder: (context) => const [
                        PopupMenuItem(value: "edit", child: Text("Edit")),

                        PopupMenuItem(value: "delete", child: Text("Delete")),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      /// ปุ่มเพิ่ม Event
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditEventScreen()),
          );
        },
      ),
    );
  }
}
