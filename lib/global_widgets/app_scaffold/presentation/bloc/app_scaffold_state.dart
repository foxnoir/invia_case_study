part of 'app_scaffold_cubit.dart';

abstract class AppScaffoldState extends Equatable {
  const AppScaffoldState();

  @override
  List<Object?> get props => [];
}

class AppScaffoldInitial extends AppScaffoldState {}

class AppScaffoldLoading extends AppScaffoldState {}

class AppScaffoldAdded extends AppScaffoldState {
  const AppScaffoldAdded(this.hotel);
  final Hotel hotel;

  @override
  List<Object?> get props => [hotel];
}

class AppScaffoldError extends AppScaffoldState {
  const AppScaffoldError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
