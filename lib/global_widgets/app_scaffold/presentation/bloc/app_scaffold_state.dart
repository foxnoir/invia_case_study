import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

abstract class AppScaffoldState extends Equatable {
  const AppScaffoldState();

  @override
  List<Object?> get props => [];
}

class AppScaffoldInitial extends AppScaffoldState {
  const AppScaffoldInitial();
}

class AppScaffoldUpdated extends AppScaffoldState {
  const AppScaffoldUpdated({required this.hotel, required this.favorites});
  final Hotel hotel;
  final List<Hotel> favorites;

  @override
  List<Object?> get props => [hotel, favorites];
}

class AppScaffoldError extends AppScaffoldState {
  const AppScaffoldError({required this.failure});
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
