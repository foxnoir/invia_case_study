import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/data/models/favorite_model.dart';
import 'package:invia_case_study/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockFavoritesDataSource extends Mock implements FavoritesDataSource {}

void main() {
  late FavoritesRepository repository;
  late MockFavoritesDataSource mockFavoritesDataSource;
  late MockLocalDatabase mockLocalDatabase;

  setUp(() {
    mockFavoritesDataSource = MockFavoritesDataSource();
    mockLocalDatabase = MockLocalDatabase();
    repository = FavoriteRepoImpl(
      localDatabase: mockLocalDatabase,
      favoritesDataSource: mockFavoritesDataSource,
    );
  });

  group('getFavorites', () {
    var tFavoriteModel = const FavoriteModel(
      id: '1',
      name: 'Test Hotel',
      category: 5,
      destination: 'Test Destination',
      bestOffer: FavoriteBestOfferModel.empty(),
      ratingInfo: FavoriteRatingInfoModel.empty(),
      hotelId: 'hotel_1',
      images: [],
    );

    final tHotel = Hotel(
      id: tFavoriteModel.id,
      name: tFavoriteModel.name,
      category: tFavoriteModel.category,
      destination: tFavoriteModel.destination,
      bestOffer: tFavoriteModel.bestOffer,
      ratingInfo: tFavoriteModel.ratingInfo,
      hotelId: tFavoriteModel.hotelId,
      images: tFavoriteModel.images.map((img) => img).toList(),
      isFavorite: true,
    );

    test('should return a list of favorite hotels when data source succeeds',
        () async {
      // Arrange
      final tFavoriteModels = [tFavoriteModel];
      final tFavoriteIds = ['1'];

      when(() => mockFavoritesDataSource.getHotels())
          .thenAnswer((_) async => tFavoriteModels);
      when(() => mockLocalDatabase.getAllFavoriteHotelIds())
          .thenReturn(tFavoriteIds);

      // Act
      final result = await repository.getFavorites();

      // Assert
      expect(result, Right([tHotel]));
      verify(() => mockFavoritesDataSource.getHotels()).called(1);
      verify(() => mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
    });

    test('should return a DatabaseFailure when an ApiException occurs',
        () async {
      // Arrange
      when(() => mockFavoritesDataSource.getHotels())
          .thenThrow(const ApiException(message: '', statusCode: 500));

      // Act
      final result = await repository.getFavorites();

      // Assert
      expect(
        result,
        const Left(
          DatabaseFailure(
              message: 'Failed to fetch favorite hotels: Test Error'),
        ),
      );
      verify(() => mockFavoritesDataSource.getHotels()).called(1);
      verifyNever(() => mockLocalDatabase.getAllFavoriteHotelIds());
    });
  });
}
