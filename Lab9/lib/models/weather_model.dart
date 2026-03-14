class WeatherModel {
  final double temperature;
  final int weatherCode;
  final List<String> dates;
  final List<double> maxTemp;
  final List<double> minTemp;

  WeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.dates,
    required this.maxTemp,
    required this.minTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json["current_weather"];
    final daily = json["daily"];

    return WeatherModel(
      temperature: current["temperature"].toDouble(),
      weatherCode: current["weathercode"],
      dates: List<String>.from(daily["time"]),
      maxTemp: List<double>.from(
        daily["temperature_2m_max"].map((e) => e.toDouble()),
      ),
      minTemp: List<double>.from(
        daily["temperature_2m_min"].map((e) => e.toDouble()),
      ),
    );
  }
}
