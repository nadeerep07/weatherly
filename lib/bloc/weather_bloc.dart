import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'package:weather_app/models/city_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

String apiKey = '9ca20e8f496973351b7bb12a0891fa50';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));
      try {
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        print(weather);
        emit(
          state.copyWith(
            weatherStatus: WeatherStatus.success,
            weather: weather,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            weatherStatus: WeatherStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<SearchCityEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));
      try {
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByCityName(event.cityName);

        // Add to search history
        final City city = City(name: event.cityName, lat: 0, lon: 0);
        List<City> updatedHistory = List.of(state.searchHistory);
        // Remove if it already exists to avoid duplicates
        updatedHistory.removeWhere(
          (c) => c.name.toLowerCase() == event.cityName.toLowerCase(),
        );
        // Add to the beginning of the list
        updatedHistory.insert(0, city);

        emit(
          state.copyWith(
            weatherStatus: WeatherStatus.success,
            weather: weather,
            searchHistory: updatedHistory,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            weatherStatus: WeatherStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<FetchCitySuggestionsEvent>((event, emit) async {
      if (event.query.isEmpty) {
        emit(
          state.copyWith(
            suggestionsStatus: SuggestionsStatus.initial,
            suggestions: [],
          ),
        );
        return;
      }

      emit(state.copyWith(suggestionsStatus: SuggestionsStatus.loading));
      try {
        final response = await http
            .get(
              Uri.parse(
                'https://api.openweathermap.org/geo/1.0/direct?q=${event.query}&limit=5&appid=$apiKey',
              ),
            )
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          final List<City> cities =
              data.map((json) => City.fromJson(json)).toList();
          emit(
            state.copyWith(
              suggestionsStatus: SuggestionsStatus.success,
              suggestions: cities,
            ),
          );
        } else {
          emit(
            state.copyWith(
              suggestionsStatus: SuggestionsStatus.failure,
              errorMessage: 'Failed to load suggestions',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            suggestionsStatus: SuggestionsStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<ClearSuggestionsEvent>((event, emit) {
      emit(
        state.copyWith(
          suggestionsStatus: SuggestionsStatus.initial,
          suggestions: [],
        ),
      );
    });
  }
}
