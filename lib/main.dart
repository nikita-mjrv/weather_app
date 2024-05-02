import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_my/bloc/weather_bloc.dart';
import 'package:weather_my/data/weather_repository.dart';
import 'package:weather_my/screens/home_screen.dart';
import 'package:weather_my/screens/settings_screen.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository();
  runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const MyApp({super.key, required this.weatherRepository});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(weatherRepository: widget.weatherRepository),
      child: MaterialApp(
        title: 'Weather App',
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        home: const HomeScreen(),
        routes: {
          '/settings': (context) => SettingsScreen(toggleTheme: toggleTheme, isDarkTheme: false,),
        },
      ),
    );
  }
}
