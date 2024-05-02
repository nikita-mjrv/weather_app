import 'package:weather_my/models/weather.dart';
import 'package:weather_my/services/weather_api.dart';

class WeatherRepository {
  final WeatherApi weatherApi;

  WeatherRepository({WeatherApi? weatherApi})
      : weatherApi = weatherApi ?? WeatherApi();

  Future<Weather> fetchWeather(String city) async {
    return weatherApi.getWeather(city);
  }
}
