import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  EventDetailsScreen(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: TextStyle(fontSize: 24)),

            SizedBox(height: 10),

            Text(event.description),

            SizedBox(height: 20),

            Text("Start: ${event.startTime}"),
            Text("End: ${event.endTime}"),
          ],
        ),
      ),
    );
  }
}
