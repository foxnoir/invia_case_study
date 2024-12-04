import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesInitial()) {
    on<FetchFavoritesEvent>(_onFetchFavorites);
  }

  final FavoritesRepository favoritesRepository =
      DI.getIt<FavoritesRepository>();

  Future<void> _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    final result = await favoritesRepository.getFavorites();
    result.fold(
      (failure) => emit(FavoritesError(message: failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites: favorites)),
    );
  }
}
