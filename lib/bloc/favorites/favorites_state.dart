part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();
  
  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}


final class FavoritesLoading extends FavoritesState {

}

final class FavoritesLoaded extends FavoritesState {
  final List<FavWeatherModel> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}