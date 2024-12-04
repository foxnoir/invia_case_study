part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required this.favorites});
  final List<Favorite> favorites;

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  const FavoritesError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
