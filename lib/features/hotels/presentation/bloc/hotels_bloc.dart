import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc() : super(const HotelsInitial()) {
    on<FetchHotelsEvent>(_onFetchHotels);
  }

  final HotelsRepository hotelsRepository = DI.getIt<HotelsRepository>();

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
