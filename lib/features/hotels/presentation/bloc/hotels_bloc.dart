import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

part 'hotels_event.dart';
part 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  HotelsBloc({HotelsRepository? hotelsRepository})
      : super(const HotelsInitial()) {
    _hotelsRepository = hotelsRepository ?? DI.getIt<HotelsRepository>();
    on<FetchHotelsEvent>(_onFetchHotels);
  }

  late HotelsRepository _hotelsRepository;

  Future<void> _onFetchHotels(
    FetchHotelsEvent event,
    Emitter<HotelsState> emit,
  ) async {
    emit(const HotelsLoading());
    final result = await _hotelsRepository.getHotels();
    result.fold(
      (failure) => emit(HotelsError(failure: failure)),
      (hotels) {
        final location = _filterLocation(hotels.first.destination);
        emit(HotelsLoaded(hotels: hotels, location: location));
      },
    );
  }

  String _filterLocation(String location) {
    final parts = location.split(',');
    return parts.length > 1 ? parts[1].trim() : '';
  }
}
