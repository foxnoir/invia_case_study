part of 'app_scaffold_bloc.dart';

abstract class AppScaffoldEvent extends Equatable {
  const AppScaffoldEvent();

  @override
  List<Object?> get props => [];
}

class ResetErrorEvent extends AppScaffoldEvent {}

class FetchFavoritesEvent extends AppScaffoldEvent {
  const FetchFavoritesEvent();
}

class AddFavoriteEvent extends AppScaffoldEvent {
  const AddFavoriteEvent(this.hotel);
  final Hotel hotel;

  @override
  List<Object?> get props => [hotel];
}

class RemoveFavoriteEvent extends AppScaffoldEvent {
  const RemoveFavoriteEvent(this.hotel);
  final Hotel hotel;

  @override
  List<Object?> get props => [hotel];
}
