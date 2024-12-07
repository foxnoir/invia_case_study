part of 'app_scaffold_bloc.dart';

abstract class AppScaffoldState {}

class AppScaffoldInitial extends AppScaffoldState {}

class AppScaffoldLoading extends AppScaffoldState {}

class AppScaffoldUpdated extends AppScaffoldState {
  AppScaffoldUpdated({required this.hotel, this.favorites});
  final Hotel hotel;
  final List<Hotel>? favorites;
}

class AppScaffoldError extends AppScaffoldState {
  AppScaffoldError({required this.failure});
  final Failure failure;
}
