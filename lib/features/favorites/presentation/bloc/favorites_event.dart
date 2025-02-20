part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavoritesEvent extends FavoritesEvent {
  const FetchFavoritesEvent();
}

class InitStateEvent extends FavoritesEvent {}
