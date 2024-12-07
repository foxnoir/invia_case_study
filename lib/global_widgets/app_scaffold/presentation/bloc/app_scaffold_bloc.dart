import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

part 'app_scaffold_event.dart';
part 'app_scaffold_state.dart';

@lazySingleton
class AppScaffoldBloc extends Bloc<AppScaffoldEvent, AppScaffoldState> {
  AppScaffoldBloc() : super(AppScaffoldInitial()) {
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ResetErrorEvent>(_onResetError);
  }

  final HotelsRepository _hotelsRepository = DI.getIt<HotelsRepository>();
  final FavoritesRepository _favoritesRepository =
      DI.getIt<FavoritesRepository>();

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    await _hotelsRepository.addFavoriteHotel(hotel: event.hotel).then(
          (result) => result.fold(
            (failure) => emit(AppScaffoldError(failure: failure)),
            (_) async {
              await _favoritesRepository.getFavorites().then(
                    (favoritesResult) => favoritesResult.fold(
                      (failure) => emit(AppScaffoldError(failure: failure)),
                      (favorites) {
                        emit(
                          AppScaffoldUpdated(
                            hotel: event.hotel.copyWith(isFavorite: true),
                            favorites: favorites,
                          ),
                        );
                      },
                    ),
                  );
            },
          ),
        );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    await _hotelsRepository.removeFavoriteHotelId(id: event.hotel.hotelId).then(
          (result) => result.fold(
            (failure) => emit(AppScaffoldError(failure: failure)),
            (_) async {
              await _favoritesRepository.getFavorites().then(
                    (favoritesResult) => favoritesResult.fold(
                      (failure) => emit(AppScaffoldError(failure: failure)),
                      (favorites) {
                        emit(
                          AppScaffoldUpdated(
                            hotel: event.hotel.copyWith(isFavorite: false),
                            favorites: favorites,
                          ),
                        );
                      },
                    ),
                  );
            },
          ),
        );
  }

  void _onResetError(
    ResetErrorEvent event,
    Emitter<AppScaffoldState> emit,
  ) {
    emit(AppScaffoldInitial());
  }
}
