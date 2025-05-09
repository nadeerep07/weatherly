import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object> get props => [];
}

class SearchLocationEvent extends LocationEvent {
  final String query;

  const SearchLocationEvent(this.query);

  @override
  List<Object> get props => [query];
}
