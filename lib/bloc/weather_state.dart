part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final WeatherData? weather; // <-- Updated type
  final String errorMessage;

  const WeatherState({
    required this.weatherStatus,
    this.weather,
    this.errorMessage = '',
  });

  factory WeatherState.initial() {
    return const WeatherState(
      weatherStatus: WeatherStatus.initial,
      weather: null,
      errorMessage: '',
    );
  }

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    WeatherData? weather,
    List<WeatherData>? searchHistory,
    List<WeatherData>? suggestions,
    String? errorMessage,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [weatherStatus, weather, errorMessage];
}
