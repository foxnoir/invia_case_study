import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotels_repo_impl.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockHotelsDataSource extends Mock implements HotelsDataSource {}

void main() {
  late MockHotelsDataSource _mockHotelsDataSource;
  late MockLocalDatabase _mockLocalDatabase;
  late HotelRepoImpl _hotelRepoImpl;

  setUp(() {
    _mockHotelsDataSource = MockHotelsDataSource();
    _mockLocalDatabase = MockLocalDatabase();

    _hotelRepoImpl = HotelRepoImpl(
      localDatabase: _mockLocalDatabase,
      hotelsDataSource: _mockHotelsDataSource,
    );
  });

  group('HotelRepoImpl', () {
    const baseHotel = HotelModel.empty();

    final tHotel1 = HotelModel(
      id: '1a',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final tHotel2 = HotelModel(
      id: '2b',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final tHotelModelsList = [tHotel1, tHotel2];

    test('should be a subclass of [HotelsRepository]', () {
      expect(_hotelRepoImpl, isA<HotelsRepository>());
    });

    test(
      'should return a [List<Hotel>] '
      'when the call to data source is successful',
      () async {
        final tFavoriteIds = ['1a', '2b', '3c'];
        when(() => _mockHotelsDataSource.getHotels())
            .thenAnswer((_) async => tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _hotelRepoImpl.getHotels();

        final expectedHotels = tHotelModelsList.map((hotel) {
          final isFavorite = tFavoriteIds.contains(hotel.id);
          return hotel.toEntity().copyWith(isFavorite: isFavorite);
        }).toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _mockHotelsDataSource.getHotels()).called(1);
        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_mockHotelsDataSource);
      },
    );

    test(
      'should return a [List<Hotel>] '
      'when the call to data source is successful and there are no favorites',
      () async {
        final tFavoriteIds = List<String>.empty();
        when(() => _mockHotelsDataSource.getHotels())
            .thenAnswer((_) async => tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _hotelRepoImpl.getHotels();

        final expectedHotels = tHotelModelsList.map((hotel) {
          final isFavorite = tFavoriteIds.contains(hotel.id);
          return hotel.toEntity().copyWith(isFavorite: isFavorite);
        }).toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _mockHotelsDataSource.getHotels()).called(1);
        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_mockHotelsDataSource);
      },
    );

    test(
      'should return [ApiFailure] when '
      'an exception is thrown while fetching hotels from the API',
      () async {
        when(() => _mockHotelsDataSource.getHotels()).thenThrow(
          const ApiException(
            message: 'Bad Request',
            statusCode: 400,
          ),
        );

        final result = await _hotelRepoImpl.getHotels();

        expect(
          result,
          equals(
            const Left<ApiFailure, List<Hotel>>(
              ApiFailure(message: 'Bad Request', statusCode: 400),
            ),
          ),
        );

        verify(() => _mockHotelsDataSource.getHotels()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_mockHotelsDataSource);
      },
    );

    test(
      'should return a [List<String> of hotel IDs] '
      'when call to local database is successful',
      () {
        final tFavoriteIds = ['1a', '2b', '3c'];
        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = _hotelRepoImpl.getFavoriteHotelIds();

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

        final result = _hotelRepoImpl.getFavoriteHotelIds();
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

    group('HotelRepoImpl - addFavoriteHotel', () {
      const tHotel = Hotel(
        id: '123',
        name: 'Test Hotel',
        category: 5,
        destination: 'Test Destination',
        bestOffer: BestOffer.empty(),
        ratingInfo: RatingInfo.empty(),
        hotelId: '123',
      );

      test(
        'should add a favorite hotel successfully and return Right(null)',
        () async {
          when(() => _mockLocalDatabase.addFavoriteHotelId(hotelId: tHotel.id))
              .thenAnswer((_) async => Future.value());

          final result = await _hotelRepoImpl.addFavoriteHotel(hotel: tHotel);

          expect(result, equals(const Right<Failure, void>(null)));
          verify(
            () => _mockLocalDatabase.addFavoriteHotelId(hotelId: tHotel.id),
          ).called(1);
          verifyNoMoreInteractions(_mockLocalDatabase);
        },
      );

      test(
        'should return [DatabaseFailure] '
        'when an exception is thrown while adding a favorite hotel',
        () async {
          when(() => _mockLocalDatabase.addFavoriteHotelId(hotelId: tHotel.id))
              .thenThrow(Exception('Some Database Error'));

          final result = await _hotelRepoImpl.addFavoriteHotel(hotel: tHotel);

          expect(
            result,
            equals(
              const Left<Failure, void>(
                DatabaseFailure(
                  message: 'Failed to add favorite hotel: '
                      'Exception: Some Database Error',
                ),
              ),
            ),
          );
          verify(
            () => _mockLocalDatabase.addFavoriteHotelId(hotelId: tHotel.id),
          ).called(1);
          verifyNoMoreInteractions(_mockLocalDatabase);
        },
      );
    });
  });
}
