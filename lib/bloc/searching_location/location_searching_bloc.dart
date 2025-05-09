import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_location.dart';

part 'location_searching_event.dart';

part 'location_searching_state.dart';

String apiKey1 = 'aae948700819404e98f41021250905';

class LocationSearchingBloc extends Bloc<LocationSearchingEvent, LocationSearchingState> {
  LocationSearchingBloc() : super(LocationSearchingState.initial()) {
   on<FetchSearchingEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: SearchLocationStatus.loading));
      try {
        final response = await http.get(
          Uri.parse(
            'https://api.weatherapi.com/v1/forecast.json?key=$apiKey1&q=${event.locationName}',
          ),
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final weather = WeatherLocation.fromJson(json);
          emit(
            state.copyWith(
              weatherStatus:  SearchLocationStatus.success,
              weather: weather,
            ),
          );
        } else {
          emit(
            state.copyWith(
              weatherStatus: SearchLocationStatus.failure,
              errorMessage: 'Failed to load weather data',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            weatherStatus: SearchLocationStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
