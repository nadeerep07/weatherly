import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/fav_weather_model.dart';
import 'package:weather_app/models/favorite_model.dart';
import 'package:weather_app/services/favorite_api_service.dart';
import 'package:weather_app/services/weather_api_services.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try{
         List<FavoriteModel> favorites = await Api.getFavorite();

        List<Future<FavWeatherModel?>> weatherFutures = favorites.map((fav) async {
          try {
            return await WeatherService.getWeather(fav.name);
          } catch (_) {
            return null;
          }
        }).toList();

        final results = await Future.wait(weatherFutures);
        final nonNullResults = results.whereType<FavWeatherModel>().toList();

        if (nonNullResults.isEmpty) {
          emit(const FavoritesError("No favorite weather data found."));
        } else {
          emit(FavoritesLoaded(nonNullResults));
        }
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
      
    });
  }
}
