// for every func in here we have a module in in the usecase folder
import 'package:dartz/dartz.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

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

class FavoriteRepoImplementation implements FavoritesRepository {
  final FavoritesDataSource _favoritesDataSource =
      DI.getIt<FavoritesDataSource>();

  @override
  ResultFuture<List<Favorite>> getFavorites() async {
    try {
      final result = await _favoritesDataSource.getFavorites();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
