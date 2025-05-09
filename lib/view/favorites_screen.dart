import 'package:flutter/material.dart';
import 'package:weather_app/models/fav_weather_model.dart';
import 'package:weather_app/models/favorite_model.dart';
import 'package:weather_app/services/favorite_api_service.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<FavWeatherModel>> favoriteWeathers; // Declare it as Future

  @override
  void initState() {
    super.initState();
    favoriteWeathers = loadFavoriteWeathers(); // Initialize it with the Future
  }
Future<List<FavWeatherModel>> loadFavoriteWeathers() async {
  List<FavoriteModel> favorites = await Api.getFavorite();

  // Create list of future weather calls
  List<Future<FavWeatherModel?>> weatherFutures = favorites.map((fav) async {
    try {
      return await WeatherService.getWeather(fav.name);
    } catch (e) {
      print("Failed to fetch weather for ${fav.name}");
      return null;
    }
  }).toList();

  // Await all in parallel
  final results = await Future.wait(weatherFutures);

  // Filter out any null results due to failed fetches
  return results.whereType<FavWeatherModel>().toList();
}


  @override
  Widget build(BuildContext context) {
    final isDaytime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;
    final colors = isDaytime
        ? [Colors.blue.shade300, Colors.blue.shade700]
        : [Colors.indigo.shade900, Colors.black];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: colors,
          ),
        ),
        child: FutureBuilder<List<FavWeatherModel>>(
          future: favoriteWeathers, // Provide the Future here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No favorite locations found"));
            } else {
              final favoriteWeathers = snapshot.data!;
              return ListView.builder(
                itemCount: favoriteWeathers.length,
                itemBuilder: (context, index) {
                  final weather = favoriteWeathers[index];
                  return WeatherCard(weather: weather); // Make sure WeatherCard is properly defined
                },
              );
            }
          },
        ),
      ),
    );
  }
}
