part of 'hotels_bloc.dart';

abstract class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object?> get props => [];
}

class HotelsInitial extends HotelsState {
  const HotelsInitial();
}

class HotelsLoading extends HotelsState {
  const HotelsLoading();
}

class HotelsLoaded extends HotelsState {
  const HotelsLoaded({required this.hotels});
  final List<Hotel> hotels;

  @override
  List<Object?> get props => [hotels];
}

class HotelsError extends HotelsState {
  const HotelsError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
