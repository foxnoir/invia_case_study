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
  FavoriteRepoImpl({
    LocalDatabase? localDatabase,
    FavoritesDataSource? favoritesDataSource,
  }) {
    _localDatabase = localDatabase ?? DI.getIt<LocalDatabase>();
    _favoritesDataSource =
        favoritesDataSource ?? DI.getIt<FavoritesDataSource>();
  }

  late LocalDatabase _localDatabase;
  late FavoritesDataSource _favoritesDataSource;

  @override
  ResultFuture<List<Hotel>> getFavorites() async {
    try {
      final hotelModels = await _favoritesDataSource.ge_tHotels();
      final favoriteIdsResult = getFavoriteHotelIds();
      final favoriteIds = favoriteIdsResult.getOrElse(() => []);

      final favorites = hotelModels
          .where((hotel) => favoriteIds.contains(hotel.id))
          .map((model) => model.toEntity().copyWith(isFavorite: true))
          .toList();

      return Right(favorites);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultSync<List<String>> getFavoriteHotelIds() {
    try {
      final ids = _localDatabase.getAllFavoriteHotelIds();
      return Right(ids);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: 'Failed to fetch hotel IDs: $e'));
    }
  }
}
