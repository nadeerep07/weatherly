import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models/weather_location.dart' show WeatherLocation;
import 'package:weather_app/widgets/build_weather_widget.dart';
import 'package:weather_app/widgets/colors.dart';


class DetailScreen extends StatelessWidget {
  final WeatherLocation weather;

  const DetailScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDaytime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;
    final colors =
        isDaytime
            ? [Colors.blue.shade300, Colors.blue.shade700]
            : [Colors.indigo.shade900, Colors.black];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: isDaytime ? Colors.black : Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
                isDaytime ? AppColors.dayGradient : AppColors.nightGradient,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: isDaytime ? Brightness.dark : Brightness.light,
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: colors,
          ),
        ),
        child: BuildWeatherWidget(context: context, colors: colors, isDaytime: isDaytime, weather: weather),
      ),
    );
  }
}
