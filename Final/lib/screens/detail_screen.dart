import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';
import 'edit_workout_screen.dart';

class DetailScreen extends StatelessWidget {
  final Workout workout;

  const DetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditWorkoutScreen(workout: workout),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.activity,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("Type: ${workout.type}"),
            Text("Duration: ${workout.duration} minutes"),
            Text("Calories: ${workout.calories} kcal"),
            Text("Date: ${workout.date}"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text("Delete Workout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete this workout?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("Delete"),
                          onPressed: () {
                            Provider.of<WorkoutProvider>(context,
                                    listen: false)
                                .deleteWorkout(workout.id!);

                            Navigator.pop(context);
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Workout deleted"),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}