import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/favorite_model.dart';
import 'package:weather_app/models/weather_location.dart' show WeatherLocation;
import 'package:weather_app/services/favorite_api_service.dart';
import 'package:weather_app/view/home_screen.dart';
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
        child: _buildWeatherScreen(context, colors, isDaytime, weather),
      ),
    );
  }

  Widget _buildWeatherScreen(
    BuildContext context,
    List<Color> colors,
    bool isDaytime,
    WeatherLocation weather,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                weather.searchcity,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${weather.searchtemperature.toString()}°C',

            style: const TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(weather.searchiconUrl, width: 50, height: 50),
              const SizedBox(width: 5),
              Text(
                weather.searchcondition,

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            ' ${weather.searchcountry}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white.withValues(alpha: .7),
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSunInfo(Icons.wb_sunny, 'Sunrise', weather.searchsunrise),
                _buildSunInfo(Icons.nights_stay, 'Sunset', weather.searchsunset),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withValues(alpha: .7),
            thickness: 1,
            height: 40,
            endIndent: 35,
            indent: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTempInfo(Icons.thermostat, 'Max', weather.searchmaxTemp),
                _buildTempInfo(Icons.thermostat_sharp, 'Min', weather.searchminTemp),
              ],
            ),
          ),
          const SizedBox(height: 50),
     Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    ElevatedButton.icon(
      onPressed: () async {
        try {
          FavoriteModel weatherLocation = FavoriteModel(
            name: weather.searchcity,
            region: weather.searchregion,
            country: weather.searchcountry,
          );
          await Api.addFavorite(weatherLocation);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${weather.searchcity} added to favorites!'),
              duration: const Duration(seconds: 2),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add ${weather.searchcity} to favorites'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      label: const Text('Add to Favorites'),
      icon: const Icon(Icons.favorite),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: isDaytime ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    const SizedBox(width: 10),
    ElevatedButton.icon(
      onPressed: () async {
        context.read<WeatherBloc>().add(FetchWeatherLocationEvent(weather.searchcity));
        
        // Navigator.popUntil(context, (route) => route.isFirst); // Return to the first route
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${weather.searchcity} set as home location!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      label: const Text('Set as Home'),
      icon: const Icon(Icons.home),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: isDaytime ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    const SizedBox(width: 20),
  ],
),
        ],
      ),
    );
  }

  Widget _buildSunInfo(IconData icon, String label, String? time) {
    return Row(
      children: [
        Icon(
          icon,
          color: icon == Icons.wb_sunny ? Colors.yellow : Colors.deepPurple,
          size: 50,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              time ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white.withValues(alpha: .7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTempInfo(IconData icon, String label, double? temp) {
    return Row(
      children: [
        Icon(
          icon,
          color: icon == Icons.thermostat ? Colors.green : Colors.blue,
          size: 50,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${temp?.toString()}°C',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white.withValues(alpha: .7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
