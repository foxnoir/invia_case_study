import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({FavoritesRepository? favoritesRepository})
      : super(const FavoritesInitial()) {
    _favoritesRepository =
        favoritesRepository ?? DI.getIt<FavoritesRepository>();
    on<FetchFavoritesEvent>(_onFetchFavorites);
  }

  late FavoritesRepository _favoritesRepository;

  Future<void> _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    final result = await _favoritesRepository.getFavorites();
    result.fold(
      (failure) => emit(FavoritesError(failure: failure)),
      (hotels) {
        emit(FavoritesLoaded(favorites: hotels));
      },
    );
  }
}
