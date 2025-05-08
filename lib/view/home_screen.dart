import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/navigation_cubit.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/view/favorities_screen.dart';
import 'package:weather_app/widgets/colors.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDaytime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;
    final colors =
        isDaytime
            ? [Colors.blue.shade300, Colors.blue.shade700]
            : [Colors.indigo.shade900, Colors.black];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: colors,
            ),
          ),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return BlocBuilder<NavigationCubit, int>(
                builder: (context, currentIndex) {
                  return IndexedStack(
                    index: currentIndex,
                    children: [
                      _buildWeatherContent(context, colors, isDaytime, state),
                      const FavoritesScreen(),
                    ],
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: isDaytime ? Colors.blue.shade700 : Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade400,
              onTap: (index) {
                context.read<NavigationCubit>().updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: 'Weather',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWeatherContent(
    BuildContext context,
    List<Color> colors,
    bool isDaytime,
    WeatherState state,
  ) {
    if (state.weatherStatus == WeatherStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.weatherStatus == WeatherStatus.failure) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    } else if (state.weatherStatus == WeatherStatus.success &&
        state.weather != null) {
      return _buildWeatherScreen(context, colors, isDaytime, state.weather!);
    } else {
      return const Center(child: Text('No weather data available'));
    }
  }

  Widget _buildWeatherScreen(
    BuildContext context,
    List<Color> colors,
    bool isDaytime,
    Weather weather,
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
                weather.areaName ?? 'Unknown',
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
            '${weather.temperature?.celsius?.toInt() ?? 0}°C',
            style: const TextStyle(
              fontSize: 68,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://openweathermap.org/img/wn/${weather.weatherIcon ?? '01d'}@2x.png',
                width: 50,
                height: 50,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.cloud, size: 50),
              ),
              const SizedBox(width: 10),
              Text(
                weather.weatherDescription ?? 'N/A',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            weather.date != null
                ? DateFormat('EEEE dd ').add_jm().format(weather.date!)
                : 'N/A',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.wb_sunny, color: Colors.yellow, size: 50),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sunrise',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          weather.sunrise != null
                              ? '${weather.sunrise!.hour}:${weather.sunrise!.minute.toString().padLeft(2, '0')} AM'
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.nights_stay,
                      color: Colors.deepPurple,
                      size: 50,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sunset',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          weather.sunset != null
                              ? '${weather.sunset!.hour}:${weather.sunset!.minute.toString().padLeft(2, '0')} PM'
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
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
                Row(
                  children: [
                    const Icon(Icons.thermostat, color: Colors.green, size: 50),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${weather.tempMax?.celsius?.toInt() ?? 0}°C',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.thermostat_sharp,
                      color: Colors.blue,
                      size: 50,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Min',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${weather.tempMin?.celsius?.toInt() ?? 0}°C',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
