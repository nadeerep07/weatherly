import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location_bloc.dart';
import 'package:weather_app/bloc/location_event.dart';
import 'package:weather_app/bloc/location_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDaytime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;
    final colors =
        isDaytime
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 50,
              ),
              child: TextField(
                onChanged: (value) {
                  context.read<LocationBloc>().add(SearchLocationEvent(value));
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDaytime ? Colors.white : Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter city name',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state.status == LocationStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == LocationStatus.success) {
                    return ListView.builder(
                      itemCount: state.locations.length,
                      itemBuilder: (context, index) {
                        final location = state.locations[index];
                        return ListTile(
                          title: Text(location.name),
                          subtitle: Text(
                            '${location.region}, ${location.country}',
                          ),
                          leading: const Icon(Icons.location_city),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_rounded),
                          ),
                        );
                      },
                    );
                  } else if (state.status == LocationStatus.failure) {
                    return Center(child: Text(state.error));
                  }
                  return const Center(child: Text('Start typing to search'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
