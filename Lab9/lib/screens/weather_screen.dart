import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService service = WeatherService();

  Map<String, dynamic>? weather;
  String city = "Bangkok";

  Future<void> loadWeather(String city) async {
    final data = await service.getWeather(city);

    setState(() {
      weather = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeather(city);
  }

  LinearGradient getBackground(double temp) {
    if (temp > 30) {
      return const LinearGradient(
        colors: [Colors.orange, Colors.deepOrange],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    if (temp > 20) {
      return const LinearGradient(
        colors: [Colors.lightBlue, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    return const LinearGradient(
      colors: [Colors.blueGrey, Colors.black54],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    double temp = weather!["main"]["temp"];
    String weatherMain = weather!["weather"][0]["main"];
    int humidity = weather!["main"]["humidity"];
    double wind = weather!["wind"]["speed"];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getBackground(temp),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // SEARCH
                TextField(
                  onSubmitted: (value) {
                    city = value;
                    loadWeather(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search City",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // CITY
                Text(
                  city,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // ICON
                Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: Colors.white,
                ),

                const SizedBox(height: 10),

                // TEMP
                Text(
                  "$temp°C",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  weatherMain,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 40),

                // INFO CARDS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoCard(
                      "Humidity",
                      "$humidity %",
                      Icons.water_drop,
                    ),
                    infoCard(
                      "Wind",
                      "$wind m/s",
                      Icons.air,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
