import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/workout_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutProvider()..loadWorkouts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Workout Tracker",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}