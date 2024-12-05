// for every func in here we have a module in in the usecase folder
import 'package:dartz/dartz.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';

// talks to the data source
// data source then talks to the api / external http library
//
//
// HOW TO WRITE TESTS FOR THIS KIND OF CLASS
//
// 1. Calling the dependency
// 2. check if methods returns proper data
// 3. make sure that it returns the proper data if there is no exception
// otherwise:
// check if when remoteDataSource throws exception, we return a failure

// Repository Implementation
class FavoriteRepoImpl implements FavoritesRepository {
  final LocalDatabase _localDatabase = DI.getIt<LocalDatabase>();

  @override
  ResultSync<List<Hotel>> getFavorites() {
    try {
      final result = _localDatabase.getallFavoriteHotels();
      return Right(result.map((model) => model.toHotel()).toList());
    } on ApiException catch (e) {
      return Left(DatabaseFailure(message: 'Failed to add fetch hotel: $e'));
    }
  }
}
