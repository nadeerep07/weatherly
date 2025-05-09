import 'package:equatable/equatable.dart';
import 'package:weather_app/models/favorite_model.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState extends Equatable {
  final LocationStatus status;
  final List<FavoriteModel> locations;
  final String error;

  const LocationState({
    this.status = LocationStatus.initial,
    this.locations = const [],
    this.error = '',
  });

  LocationState copyWith({
    LocationStatus? status,
    List<FavoriteModel>? locations,
    String? error,
  }) {
    return LocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, locations, error];
}
