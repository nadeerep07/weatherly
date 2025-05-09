import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_event.dart';
import 'package:weather_app/bloc/location/location_state.dart';
import 'package:weather_app/models/favorite_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<SearchLocationEvent>(_onSearchLocation);
  }

  Future<void> _onSearchLocation(
    SearchLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      final response = await http.get(
        Uri.parse(
          'http://api.weatherapi.com/v1/search.json?key=aae948700819404e98f41021250905&q=${event.query}',
        ),
      );

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        final List<dynamic> jsonData = json.decode(response.body);
        final List<FavoriteModel> locations =
            jsonData.map((e) => FavoriteModel.fromJson(e)).toList();
        emit(
          state.copyWith(status: LocationStatus.success, locations: locations),
        );
        print("API Response: ${locations.length}");
      } else {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            error: 'Failed to load',
          ),
        );
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: LocationStatus.failure, error: e.toString()));
    }
  }
}
