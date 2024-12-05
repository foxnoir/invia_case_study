part of 'app_scaffold_bloc.dart';

abstract class AppScaffoldState {}

class AppScaffoldInitial extends AppScaffoldState {}

class AppScaffoldLoading extends AppScaffoldState {}

class AppScaffoldUpdated extends AppScaffoldState {
  AppScaffoldUpdated({required this.hotel});
  final Hotel hotel;
}

class AppScaffoldError extends AppScaffoldState {
  AppScaffoldError({required this.message});
  final String message;
}
