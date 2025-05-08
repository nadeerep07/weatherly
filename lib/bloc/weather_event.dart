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

class FetchCitySuggestionsEvent extends WeatherEvent {
  final String query;

  const FetchCitySuggestionsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSuggestionsEvent extends WeatherEvent {}

class LoadFavoritesEvent extends WeatherEvent {}
