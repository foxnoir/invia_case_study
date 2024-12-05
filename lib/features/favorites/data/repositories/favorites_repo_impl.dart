// for every func in here we have a module in in the usecase folder
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
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
  List<Favorite> getFavorites() {
    try {
      final result = _localDatabase.getllFavoriteHotels();

      return result.map((favoriteHotel) => favoriteHotel.toFavorite()).toList();
    } on ApiException catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }
}
