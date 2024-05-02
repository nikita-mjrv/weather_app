class WeatherForecast {
  final String day;
  final double temperature;

  WeatherForecast({
    required this.day,
    required this.temperature,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true);
    String dayOfWeek = _getDayOfWeek(dateTime.weekday);
    double temp = (json['temp']['day'] - 273.15);

    return WeatherForecast(
      day: dayOfWeek,
      temperature: temp,
    );
  }

  static String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
