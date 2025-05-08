part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

enum SuggestionsStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final SuggestionsStatus suggestionsStatus;
  final Weather? weather;
  final List<City> suggestions;
  final List<City> searchHistory;
  final String errorMessage;

  const WeatherState({
    required this.weatherStatus,
    required this.suggestionsStatus,
    this.weather,
    required this.suggestions,
    required this.searchHistory,
    this.errorMessage = '',
  });

  factory WeatherState.initial() {
    return const WeatherState(
      weatherStatus: WeatherStatus.initial,
      suggestionsStatus: SuggestionsStatus.initial,
      suggestions: [],
      searchHistory: [],
    );
  }

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    SuggestionsStatus? suggestionsStatus,
    Weather? weather,
    List<City>? suggestions,
    List<City>? searchHistory,
    String? errorMessage,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      suggestionsStatus: suggestionsStatus ?? this.suggestionsStatus,
      weather: weather ?? this.weather,
      suggestions: suggestions ?? this.suggestions,
      searchHistory: searchHistory ?? this.searchHistory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    weatherStatus,
    suggestionsStatus,
    weather,
    suggestions,
    searchHistory,
    errorMessage,
  ];
}
