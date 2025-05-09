import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

String apiKey = '9ca20e8f496973351b7bb12a0891fa50';
String apiKey1 = 'aae948700819404e98f41021250905';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));

      try {
        final response = await http.get(
          Uri.parse(
            'https://api.weatherapi.com/v1/forecast.json?key=$apiKey1&q=${event.position.latitude},${event.position.longitude}',
          ),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = jsonDecode(response.body);
          final weather = WeatherData.fromJson(json);
          print(weather.sunrise);
          emit(
            state.copyWith(
              weatherStatus: WeatherStatus.success,
              weather: weather,
            ),
          );
        } else {
          emit(
            state.copyWith(
              weatherStatus: WeatherStatus.failure,
              errorMessage: 'Failed to load weather data',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            weatherStatus: WeatherStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
