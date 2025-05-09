import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/location/location_event.dart';
import 'package:weather_app/bloc/searching_location/location_searching_bloc.dart';
import 'package:weather_app/bloc/location/location_state.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/view/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

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
                controller: _controller,
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                      context.read<LocationBloc>().add(
                        const SearchLocationEvent(''),
                      );
                    },
                    icon: const Icon(Icons.clear),
                  ),
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
                          title: Text(location.name, style: TextStyle(color: isDaytime ? Colors.black : Colors.white),),
                          subtitle: Text(
                            ' ${location.country} ', style: TextStyle(color: isDaytime ? Colors.black : Colors.white)
                          ),
                          leading: const Icon(Icons.location_city,color: Colors.blue,),
                          onTap: () {
                            context.read<LocationSearchingBloc>().add(
                              FetchSearchingEvent(location.name),
                            );

                            // Wait for the weather fetch to complete
                            showDialog(
                              context: context,
                              builder:
                                  (
                                    _,
                                  ) => BlocConsumer<LocationSearchingBloc, LocationSearchingState>(
                                    listener: (context, state) {
                                      if (state.weatherStatus ==
                                          SearchLocationStatus.success) {
                                        Navigator.pop(context); // Close dialog
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => DetailScreen(
                                                  weather: state.weather!,
                                                ),
                                          ),
                                        );
                                      } else if (state.weatherStatus ==
                                          WeatherStatus.failure) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(state.errorMessage ?? 'An unknown error occurred'),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                            );
                          },
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
