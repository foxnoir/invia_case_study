part of 'hotels_bloc.dart';

abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

class FetchHotelsEvent extends HotelsEvent {
  const FetchHotelsEvent();
}

class InitStateEvent extends HotelsEvent {}
