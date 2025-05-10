import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/favorites/favorites_bloc.dart';

import 'package:weather_app/widgets/weather_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
} 

class _FavoritesScreenState extends State<FavoritesScreen> {

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
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          // 🔁 Trigger loading if state is initial
          if (state is FavoritesInitial) {
            context.read<FavoritesBloc>().add(LoadFavorites());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text("No favorite locations found"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FavoritesBloc>().add(LoadFavorites());
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final weather = state.favorites[index];
                  return WeatherCard(weather: weather);
                },
              ),
            );
          }

          return const Center(child: Text("No favorite locations found"));
        },
      ),
    ),
  );
}

}
