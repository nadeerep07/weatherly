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

class FetchWeatherLocationEvent extends WeatherEvent {
  final String locationName;
  const FetchWeatherLocationEvent(this.locationName);

  @override
  List<Object> get props => [locationName];
}
