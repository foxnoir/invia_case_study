import 'package:dartz/dartz.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';

class FavoriteRepoImpl implements FavoritesRepository {
  final LocalDatabase _localDatabase = DI.getIt<LocalDatabase>();
  final FavoritesDataSource _favoritesDataSource =
      DI.getIt<FavoritesDataSource>();

  @override
  ResultFuture<List<Hotel>> getFavorites() async {
    try {
      final hotelModels = await _favoritesDataSource.getHotels();
      final favoriteIdsResult = getFavoriteHotelIds();
      final favoriteIds = favoriteIdsResult.getOrElse(() => []);

      final favorites = hotelModels
          .where((hotel) => favoriteIds.contains(hotel.id))
          .map((model) => model.toEntity().copyWith(isFavorite: true))
          .toList();

      return Right(favorites);
    } on ApiException catch (e) {
      return Left(
        DatabaseFailure(message: 'Failed to fetch favorite hotels: $e'),
      );
    }
  }

  @override
  ResultSync<List<String>> getFavoriteHotelIds() {
    try {
      final ids = _localDatabase.getAllFavoriteHotelIds();
      return Right(ids);
    } on ApiException catch (e) {
      return Left(DatabaseFailure(message: 'Failed to fetch hotel IDs: $e'));
    }
  }
}
