import 'package:bloc/bloc.dart';
import 'package:weather_my/data/weather_repository.dart';
import 'package:weather_my/models/weather.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<GetWeather>(_onGetWeather);
  }

  void _onGetWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      print('Error fetching weather: $e');
      emit(const WeatherError(message: 'Unknown city'));
    }
  }
}
