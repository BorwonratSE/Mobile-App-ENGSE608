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

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<WorkoutProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Workout Tracker"),
        centerTitle: true,

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
          ),
        ],
      ),

      body: Column(

        children: [

          /// SEARCH
          Padding(
            padding: const EdgeInsets.all(10),

            child: TextField(

              controller: searchController,

              decoration: InputDecoration(

                hintText: "Search workout...",

                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onChanged: (value) {

                provider.search = value;
                provider.notifyListeners();
              },
            ),
          ),

          /// FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),

            child: Row(

              children: [

                const Text(
                  "Filter:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(width: 10),

                DropdownButton<String>(

                  value: provider.filterType,

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
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// LIST WORKOUT
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

                          color: Colors.red,

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

                          elevation: 3,

                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: ListTile(

                            leading: const CircleAvatar(
                              child: Icon(Icons.fitness_center),
                            ),

                            title: Text(
                              workout.activity,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                                "${workout.type} • ${workout.duration} min"),

                            trailing: const Icon(Icons.arrow_forward_ios),

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
      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

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