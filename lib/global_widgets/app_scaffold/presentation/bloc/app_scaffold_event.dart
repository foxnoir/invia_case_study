part of 'app_scaffold_bloc.dart';

abstract class AppScaffoldEvent extends Equatable {
  const AppScaffoldEvent();

  @override
  List<Object?> get props => [];
}

class ResetErrorEvent extends AppScaffoldEvent {}

class AddFavoriteEvent extends AppScaffoldEvent {
  const AddFavoriteEvent(this.hotel);
  final HotelEntity hotel;

  @override
  List<Object?> get props => [hotel];
}

class RemoveFavoriteEvent extends AppScaffoldEvent {
  const RemoveFavoriteEvent(this.hotel);
  final HotelEntity hotel;

  @override
  List<Object?> get props => [hotel];
}
