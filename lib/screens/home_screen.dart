import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_my/bloc/weather_bloc.dart';
import 'package:weather_my/bloc/weather_event.dart';
import 'package:weather_my/bloc/weather_state.dart';
import 'package:weather_my/models/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: ('Enter a city'),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                          ),
                          onPressed: () {
                            _cityController.clear();
                          },
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        _submitCity(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return const Text('Enter a city to get started');
                  } else if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    final Weather weather = state.weather;
                    return Column(
                      children: [
                        Text(
                          '${weather.city}: ${weather.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          weather.description,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Text(
                      'Failed to fetch weather: ${state.message}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                    );
                  } else {
                    return const Text('Unknown state');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitCity(BuildContext context) {
    final enteredCity = _cityController.text;
    if (enteredCity.trim().isNotEmpty) {
      BlocProvider.of<WeatherBloc>(context).add(GetWeather(city: enteredCity));
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
