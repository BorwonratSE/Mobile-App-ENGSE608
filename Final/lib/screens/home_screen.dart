import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import 'add_workout_screen.dart';
import 'detail_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController searchController = TextEditingController();

  Icon getIcon(String type) {
    switch (type) {
      case "Cardio":
        return const Icon(Icons.directions_run, color: Colors.orange);
      case "Strength":
        return const Icon(Icons.fitness_center, color: Colors.red);
      case "Flexibility":
        return const Icon(Icons.self_improvement, color: Colors.green);
      default:
        return const Icon(Icons.sports);
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<WorkoutProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Workout Tracker"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );
            },
          )
        ],
      ),

      body: Column(
        children: [

          /// SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search workout...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                provider.search = value;
                provider.notifyListeners();
              },
            ),
          ),

          /// FILTER + SORT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [

                  const Text(
                    "Filter:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(width: 10),

                  DropdownButton<String>(
                    value: provider.filterType,
                    underline: const SizedBox(),
                    items: ["All", "Cardio", "Strength", "Flexibility"]
                        .map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      provider.filterType = value!;
                      provider.notifyListeners();
                    },
                  ),

                  const Spacer(),

                  const Text(
                    "Sort:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(width: 10),

                  DropdownButton<String>(
                    value: provider.sortBy,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                          value: "date", child: Text("Date")),
                      DropdownMenuItem(
                          value: "name", child: Text("Name")),
                      DropdownMenuItem(
                          value: "duration", child: Text("Duration")),
                    ],
                    onChanged: (value) {
                      provider.sortBy = value!;
                      provider.notifyListeners();
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// WORKOUT LIST
          Expanded(
            child: provider.workouts.isEmpty
                ? const Center(
                    child: Text(
                      "No workout data",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.workouts.length,
                    itemBuilder: (context, index) {

                      Workout workout = provider.workouts[index];

                      return Dismissible(

                        key: Key(workout.id.toString()),

                        direction: DismissDirection.endToStart,

                        background: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                        onDismissed: (direction) {

                          provider.deleteWorkout(workout.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Workout deleted"),
                            ),
                          );
                        },

                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(

                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: getIcon(workout.type),
                            ),

                            title: Text(
                              workout.activity,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              "${workout.type} • ${workout.duration} min\n${workout.date.split(" ")[0]}",
                            ),

                            isThreeLine: true,

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailScreen(workout: workout),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      /// ADD BUTTON
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Workout"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddWorkoutScreen(),
            ),
          );
        },
      ),
    );
  }
}