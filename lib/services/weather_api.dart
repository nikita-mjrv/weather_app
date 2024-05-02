import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_my/models/weather.dart';

class WeatherApi {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String apiKey = '4e5ede1657ba58e58cf9b3bc13e4baa0';

  Future<Weather> getWeather(String cityName) async {
    final String apiUrl = '$baseUrl?q=$cityName&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Weather.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch weather: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      throw Exception('Failed to fetch weather');
    }
  }
}
