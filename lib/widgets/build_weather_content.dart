import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/widgets/build_weather_screen.dart';

class BuildWeatherContent extends StatelessWidget {
  const BuildWeatherContent({
    super.key,
    required this.context,
    required this.colors,
    required this.isDaytime,
    required this.state,
  });

  final BuildContext context;
  final List<Color> colors;
  final bool isDaytime;
  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    if (state.weatherStatus == WeatherStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.weatherStatus == WeatherStatus.failure) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    } else if (state.weatherStatus == WeatherStatus.success &&
        state.weather != null) {
      return BuildWeatherScreen(context: context, colors: colors, isDaytime: isDaytime, weather: state.weather!);
    } else {
      return const Center(child: Text('No weather data available'));
    }
  }
}
