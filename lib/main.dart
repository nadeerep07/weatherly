import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/favorites/favorites_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/searching_location/location_searching_bloc.dart';
import 'package:weather_app/bloc/search_query_cubit.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/view/splash_screen.dart';
import 'package:weather_app/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final position = await _determinePosition();

  runApp(MyApp(position: position));
}

class MyApp extends StatelessWidget {
  final Position position;

  const MyApp({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc()..add(FetchWeatherEvent(position)),
        ),
        BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
         BlocProvider(create: (_) => SearchQueryCubit()), 
        BlocProvider<LocationSearchingBloc>(
          create: (context) => LocationSearchingBloc(),
        ),
        BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreen(),
        routes: {'/home': (context) => const HomeScreen()},
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  return await Geolocator.getCurrentPosition();
}
