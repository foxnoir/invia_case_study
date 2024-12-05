import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';

part 'app_scaffold_event.dart';
part 'app_scaffold_state.dart';

@lazySingleton
class AppScaffoldBloc extends Bloc<AppScaffoldEvent, AppScaffoldState> {
  AppScaffoldBloc() : super(AppScaffoldInitial()) {
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ResetErrorEvent>(_onResetError); // ResetErrorEvent Handler hinzufügen
  }

  final HotelsRepository hotelsRepository = DI.getIt<HotelsRepository>();

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    try {
      await hotelsRepository.addFavoriteHotel(hotel: event.hotel);
      emit(AppScaffoldUpdated(hotel: event.hotel.copyWith(isFavorite: true)));
    } catch (e) {
      emit(AppScaffoldError(message: 'Error adding favorite: $e'));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    try {
      await hotelsRepository.removeFavoriteHotelById(id: event.hotel.hotelId);
      emit(AppScaffoldUpdated(hotel: event.hotel.copyWith(isFavorite: false)));
    } catch (e) {
      emit(AppScaffoldError(message: 'Error removing favorite: $e'));
    }
  }

  void _onResetError(
    ResetErrorEvent event,
    Emitter<AppScaffoldState> emit,
  ) {
    emit(AppScaffoldInitial()); // Zurücksetzen des Zustands
  }
}
