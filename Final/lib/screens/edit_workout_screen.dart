import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';
import '../providers/workout_provider.dart';

class EditWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const EditWorkoutScreen({super.key, required this.workout});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController activity;
  late TextEditingController duration;
  late TextEditingController calories;

  String type = "Cardio";

  @override
  void initState() {
    super.initState();

    activity = TextEditingController(text: widget.workout.activity);
    duration =
        TextEditingController(text: widget.workout.duration.toString());
    calories =
        TextEditingController(text: widget.workout.calories.toString());

    type = widget.workout.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Workout"),
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
                    return "Please enter activity";
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
              ElevatedButton(
                child: const Text("Update Workout"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final workout = Workout(
                      id: widget.workout.id,
                      activity: activity.text,
                      type: type,
                      duration: int.parse(duration.text),
                      calories: int.parse(calories.text),
                      date: widget.workout.date,
                      note: widget.workout.note,
                    );

                    Provider.of<WorkoutProvider>(context, listen: false)
                        .updateWorkout(workout);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Workout updated successfully"),
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