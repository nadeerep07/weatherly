part of 'location_searching_bloc.dart';

enum SearchLocationStatus { initial, loading, success, failure }

class LocationSearchingState extends Equatable {
  final SearchLocationStatus weatherStatus;
  final WeatherLocation? weather;
  final String? errorMessage;

  const LocationSearchingState({
    this.weatherStatus = SearchLocationStatus.initial,
    this.weather,
    this.errorMessage,
  });
   factory LocationSearchingState.initial() {
    return const LocationSearchingState(
      weatherStatus: SearchLocationStatus.initial,
      weather: null,
      errorMessage: '',
    );
  }

  LocationSearchingState copyWith({
    SearchLocationStatus? weatherStatus,
    WeatherLocation? weather,
    String? errorMessage,
  }) {
    return LocationSearchingState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [weatherStatus, weather, errorMessage];
}
