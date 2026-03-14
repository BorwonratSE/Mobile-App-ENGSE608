import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/category_provider.dart';
import 'providers/event_provider.dart';
import 'screens/activity_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider()..loadCategories(),
        ),
        ChangeNotifierProvider(create: (_) => EventProvider()..loadEvents()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Activity Tracker",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ActivityListScreen(),
      ),
    );
  }
}
