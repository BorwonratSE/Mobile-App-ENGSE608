import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/workout_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);

    int totalSessions = provider.total;

    int totalDuration = provider.workouts.fold(
      0,
      (sum, workout) => sum + workout.duration,
    );

    int totalCalories = provider.workouts.fold(
      0,
      (sum, workout) => sum + workout.calories,
    );

    int cardio = provider.countType("Cardio");
    int strength = provider.countType("Strength");
    int flexibility = provider.countType("Flexibility");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// STAT CARDS
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [

                statCard(
                  "Sessions",
                  totalSessions.toString(),
                  Icons.fitness_center,
                  Colors.blue,
                ),

                statCard(
                  "Duration",
                  "$totalDuration min",
                  Icons.timer,
                  Colors.orange,
                ),

                statCard(
                  "Calories",
                  totalCalories.toString(),
                  Icons.local_fire_department,
                  Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// PIE CHART
            const Text(
              "Workout Type Distribution",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: [

                    PieChartSectionData(
                      value: cardio.toDouble(),
                      title: "Cardio",
                      color: Colors.orange,
                      radius: 60,
                    ),

                    PieChartSectionData(
                      value: strength.toDouble(),
                      title: "Strength",
                      color: Colors.red,
                      radius: 60,
                    ),

                    PieChartSectionData(
                      value: flexibility.toDouble(),
                      title: "Flex",
                      color: Colors.green,
                      radius: 60,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// LEGEND
            Column(
              children: [
                legendItem("Cardio", Colors.orange),
                legendItem("Strength", Colors.red),
                legendItem("Flexibility", Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget legendItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 14,
            height: 14,
            color: color,
          ),

          const SizedBox(width: 8),

          Text(text),
        ],
      ),
    );
  }
}