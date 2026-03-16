import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final activity = TextEditingController();
  final duration = TextEditingController();
  final calories = TextEditingController();

  String type = "Cardio";

  @override
  void dispose() {
    activity.dispose();
    duration.dispose();
    calories.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Workout"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              /// ACTIVITY
              TextFormField(
                controller: activity,
                decoration: const InputDecoration(
                  labelText: "Activity",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Please enter activity";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              /// TYPE
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                ),
                items: ["Cardio", "Strength", "Flexibility"]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    type = v!;
                  });
                },
              ),

              const SizedBox(height: 15),

              /// DURATION
              TextFormField(
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Duration (minutes)",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter duration";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              /// CALORIES
              TextFormField(
                controller: calories,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Calories",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter calories";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {

                      Provider.of<WorkoutProvider>(
                        context,
                        listen: false,
                      ).addWorkout(

                        Workout(
                          activity: activity.text,
                          type: type,
                          duration: int.parse(duration.text),
                          calories: int.parse(calories.text),
                          date: DateTime.now().toString(),
                          note: "",
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Workout saved"),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}