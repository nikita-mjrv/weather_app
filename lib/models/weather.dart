import 'package:weather_my/models/weather_forecast.dart';

class Weather {
  final String city;
  final double temperature;
  final String description;
  final List<WeatherForecast> dailyForecasts;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.dailyForecasts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<WeatherForecast> forecasts = [];
    if (json['daily'] != null && json['daily'] is List) {
      List<dynamic> dailyData = json['daily'];
      for (var forecastJson in dailyData) {
        WeatherForecast forecast = WeatherForecast.fromJson(forecastJson);
        forecasts.add(forecast);
      }
    }

    return Weather(
      city: json['name'],
      temperature: (json['main']['temp'] - 273.15),
      description: json['weather'][0]['description'],
      dailyForecasts: forecasts,
    );
  }
}
