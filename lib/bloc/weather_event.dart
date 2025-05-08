part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final Position position;

  const FetchWeatherEvent(this.position);

  @override
  List<Object> get props => [position];
}

class SearchCityEvent extends WeatherEvent {
  final String cityName;

  const SearchCityEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class AddToFavoritesEvent extends WeatherEvent {
  final Weather weather;

  const AddToFavoritesEvent(this.weather);

  @override
  List<Object> get props => [weather];
}

class RemoveFromFavoritesEvent extends WeatherEvent {
  final String favoriteId;

  const RemoveFromFavoritesEvent(this.favoriteId);

  @override
  List<Object> get props => [favoriteId];
}

class LoadFavoritesEvent extends WeatherEvent {}
