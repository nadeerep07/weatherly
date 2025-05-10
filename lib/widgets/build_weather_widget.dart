import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/favorite_model.dart';
import 'package:weather_app/models/weather_location.dart' show WeatherLocation;
import 'package:weather_app/services/favorite_api_service.dart';
import 'package:weather_app/widgets/sun_info.dart';
import 'package:weather_app/widgets/temp_info.dart';

class BuildWeatherWidget extends StatelessWidget {
  const BuildWeatherWidget({
    super.key,
    required this.context,
    required this.colors,
    required this.isDaytime,
    required this.weather,
  });

  final BuildContext context;
  final List<Color> colors;
  final bool isDaytime;
  final WeatherLocation weather;

  @override
  Widget build(BuildContext context) {
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
                SunInfo(icon: Icons.wb_sunny, label: 'Sunrise', time: weather.searchsunrise),
                SunInfo(icon: Icons.nights_stay, label: 'Sunset', time: weather.searchsunset),
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
                TempInfo(icon: Icons.thermostat, label: 'Max', temp: weather.searchmaxTemp),
                TempInfo(icon: Icons.thermostat_sharp, label: 'Min', temp: weather.searchminTemp),
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
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${weather.searchcity} added to favorites!',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to add ${weather.searchcity} to favorites',
                        ),
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
                  context.read<WeatherBloc>().add(
                    FetchWeatherLocationEvent(weather.searchcity),
                  );

                  // Navigator.popUntil(context, (route) => route.isFirst); // Return to the first route
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${weather.searchcity} set as home location!',
                      ),
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
}
