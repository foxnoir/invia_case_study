import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotel_repository.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc() : super(const HotelsInitial()) {
    on<InitStateEvent>(_onInitState);
    on<FetchHotelsEvent>(_onFetchHotels);
  }

  final HotelsRepository hotelsRepository = DI.getIt<HotelsRepository>();

  Future<void> _onInitState(
    InitStateEvent event,
    Emitter<HotelsState> emit,
  ) async {
    // Initialzustand oder Logik für die Initialisierung
    emit(const HotelsInitial());
  }

  Future<void> _onFetchHotels(
    FetchHotelsEvent event,
    Emitter<HotelsState> emit,
  ) async {
    emit(const HotelsLoading());
    final result = await hotelsRepository.getHotels();
    result.fold(
      (failure) => emit(HotelsError(message: failure.message)),
      (hotels) => emit(HotelsLoaded(hotels: hotels)),
    );
  }
}
