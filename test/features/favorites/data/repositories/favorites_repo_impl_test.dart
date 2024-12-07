import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/data/models/favorite_model.dart';
import 'package:invia_case_study/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockFavoritesDataSource extends Mock implements FavoritesDataSource {}

void main() {
  late MockFavoritesDataSource _favoritesDataSource;
  late MockLocalDatabase _mockLocalDatabase;
  late FavoriteRepoImpl _favoriteRepoImpl;

  setUp(() {
    _favoritesDataSource = MockFavoritesDataSource();
    _mockLocalDatabase = MockLocalDatabase();

    _favoriteRepoImpl = FavoriteRepoImpl(
      localDatabase: _mockLocalDatabase,
      favoritesDataSource: _favoritesDataSource,
    );
  });

  group('FavoriteRepoImpl', () {
    const baseHotel = FavoriteModel.empty();

    final tHotel1 = FavoriteModel(
      id: '1a',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final tHotel2 = FavoriteModel(
      id: '2b',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final tHotelModelsList = [tHotel1, tHotel2];

    test('should be a subclass of [FavoritesRepository]', () {
      expect(_favoriteRepoImpl, isA<FavoritesRepository>());
    });

    test(
      'should return a [List<Hotel>] '
      'when the call to data source is successful',
      () async {
        final tFavoriteIds = ['1a', '2b', '3c'];
        when(() => _favoritesDataSource.getHotels())
            .thenAnswer((_) async => tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _favoriteRepoImpl.getFavorites();

        final expectedHotels = tHotelModelsList
            .where((hotel) => tFavoriteIds.contains(hotel.id))
            .map((model) => model.toEntity().copyWith(isFavorite: true))
            .toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _favoritesDataSource.getHotels()).called(1);
        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_favoritesDataSource);
      },
    );

    test(
      'should return a [] '
      'when the call to data source is successful and there are no favorites ',
      () async {
        final tFavoriteIds = List<String>.empty();
        when(() => _favoritesDataSource.getHotels())
            .thenAnswer((_) async => tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _favoriteRepoImpl.getFavorites();

        final expectedHotels = tHotelModelsList
            .where((hotel) => tFavoriteIds.contains(hotel.id))
            .map((model) => model.toEntity().copyWith(isFavorite: true))
            .toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _favoritesDataSource.getHotels()).called(1);
        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_favoritesDataSource);
      },
    );

    test(
      'should return [ApiFailure] when '
      'an exception is thrown while fetching hotels from the API',
      () async {
        when(() => _favoritesDataSource.getHotels()).thenThrow(
          const ApiException(
            message: 'Bad Request',
            statusCode: 400,
          ),
        );

        final result = await _favoriteRepoImpl.getFavorites();

        expect(
          result,
          equals(
            const Left<ApiFailure, List<Hotel>>(
              ApiFailure(message: 'Bad Request', statusCode: 400),
            ),
          ),
        );

        verify(() => _favoritesDataSource.getHotels()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_favoritesDataSource);
      },
    );

    test(
      'should return a [List<String> of hotel IDs] '
      'when call to local database is successful',
      () {
        final tFavoriteIds = ['1a', '2b', '3c'];
        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = _favoriteRepoImpl.getFavoriteHotelIds();

        expect(result, Right<Failure, List<String>>(tFavoriteIds));

        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
      },
    );

    test(
      'should return [DatabaseFailure] when an exception is thrown '
      'while fetching hotel IDs from the local database',
      () {
        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenThrow(const DatabaseException(message: 'Database Error'));

        final result = _favoriteRepoImpl.getFavoriteHotelIds();
        expect(
          result,
          equals(
            const Left<DatabaseFailure, List<String>>(
              DatabaseFailure(
                message: 'Failed to fetch hotel IDs: '
                    'DatabaseException(Database Error)',
              ),
            ),
          ),
        );

        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
      },
    );
  });
}
