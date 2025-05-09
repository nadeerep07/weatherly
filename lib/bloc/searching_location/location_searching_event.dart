part of 'location_searching_bloc.dart';

sealed class LocationSearchingEvent extends Equatable {
  const LocationSearchingEvent();

  @override
  List<Object> get props => [];
}
class FetchSearchingEvent extends LocationSearchingEvent {
   final String locationName;
  const FetchSearchingEvent(this.locationName);

  @override
  List<Object> get props => [locationName];
}

