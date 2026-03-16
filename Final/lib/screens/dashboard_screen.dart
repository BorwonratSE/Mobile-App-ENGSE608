import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/workout_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);

    final cardio = provider.countType("Cardio").toDouble();
    final strength = provider.countType("Strength").toDouble();
    final flex = provider.countType("Flexibility").toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      body: Column(
        children: [

          /// TOTAL WORKOUT CARD
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: const Text("Total Workouts"),
              trailing: Text(
                provider.total.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// PIE CHART
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,

                  sections: [

                    PieChartSectionData(
                      color: Colors.blue,
                      value: cardio,
                      title: "Cardio\n${cardio.toInt()}",
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      color: Colors.orange,
                      value: strength,
                      title: "Strength\n${strength.toInt()}",
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      color: Colors.green,
                      value: flex,
                      title: "Flex\n${flex.toInt()}",
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}