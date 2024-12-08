import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';

part 'app_scaffold_event.dart';

@lazySingleton
class AppScaffoldBloc extends Bloc<AppScaffoldEvent, AppScaffoldState> {
  AppScaffoldBloc({
    HotelsRepository? hotelsRepository,
    FavoritesRepository? favoritesRepository,
  }) : super(const AppScaffoldInitial()) {
    _hotelsRepository = hotelsRepository ?? DI.getIt<HotelsRepository>();
    _favoritesRepository =
        favoritesRepository ?? DI.getIt<FavoritesRepository>();
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ResetErrorEvent>(_onResetError);
  }

  late final HotelsRepository _hotelsRepository;
  late final FavoritesRepository _favoritesRepository;

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    final result = await _hotelsRepository.addFavoriteHotel(hotel: event.hotel);
    if (emit.isDone) return;

    await result.fold(
      (failure) {
        if (!emit.isDone) emit(AppScaffoldError(failure: failure));
      },
      (_) async {
        final favoritesResult = await _favoritesRepository.getFavorites();
        if (emit.isDone) return;

        favoritesResult.fold(
          (failure) {
            if (!emit.isDone) emit(AppScaffoldError(failure: failure));
          },
          (favorites) {
            if (!emit.isDone) {
              emit(
                AppScaffoldUpdated(
                  hotel: event.hotel.copyWith(isFavorite: true),
                  favorites: favorites,
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<AppScaffoldState> emit,
  ) async {
    final result =
        await _hotelsRepository.removeFavoriteHotelId(id: event.hotel.hotelId);
    if (emit.isDone) return;

    await result.fold(
      (failure) {
        if (!emit.isDone) emit(AppScaffoldError(failure: failure));
      },
      (_) async {
        final favoritesResult = await _favoritesRepository.getFavorites();
        if (emit.isDone) return;

        favoritesResult.fold(
          (failure) {
            if (!emit.isDone) emit(AppScaffoldError(failure: failure));
          },
          (favorites) {
            if (!emit.isDone) {
              emit(
                AppScaffoldUpdated(
                  hotel: event.hotel.copyWith(isFavorite: false),
                  favorites: favorites,
                ),
              );
            }
          },
        );
      },
    );
  }

  void _onResetError(
    ResetErrorEvent event,
    Emitter<AppScaffoldState> emit,
  ) {
    emit(const AppScaffoldInitial());
  }
}
