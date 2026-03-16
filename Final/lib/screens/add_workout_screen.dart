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

  DateTime selectedDate = DateTime.now();

  Future pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context, listen: false);

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
              TextFormField(
                controller: activity,
                decoration: const InputDecoration(labelText: "Activity"),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter activity";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: type,
                items: ["Cardio", "Strength", "Flexibility"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    type = v!;
                  });
                },
                decoration: const InputDecoration(labelText: "Type"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: duration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Duration"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: calories,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Calories"),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: pickDate,
                    child: const Text("Select Date"),
                  )
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text("Save Workout"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final workout = Workout(
                      activity: activity.text,
                      type: type,
                      duration: int.parse(duration.text),
                      calories: int.parse(calories.text),
                      date: selectedDate.toString(),
                      note: "",
                    );

                    provider.addWorkout(workout);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Workout saved successfully"),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}