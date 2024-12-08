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

    final _tHotel1 = HotelModel(
      id: '1a',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final _tHotel2 = HotelModel(
      id: '2b',
      name: baseHotel.name,
      category: baseHotel.category,
      destination: baseHotel.destination,
      bestOffer: baseHotel.bestOffer,
      ratingInfo: baseHotel.ratingInfo,
      hotelId: baseHotel.hotelId,
    );

    final _tHotelModelsList = [_tHotel1, _tHotel2];

    test('should be a subclass of [HotelsRepository]', () {
      expect(_hotelRepoImpl, isA<HotelsRepository>());
    });

    test(
      'should return a [List<Hotel>] '
      'when the call to data source is successful',
      () async {
        final tFavoriteIds = ['1a', '2b', '3c'];
        when(() => _mockHotelsDataSource.ge_tHotels())
            .thenAnswer((_) async => _tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _hotelRepoImpl.ge_tHotels();

        final expectedHotels = _tHotelModelsList.map((hotel) {
          final isFavorite = tFavoriteIds.contains(hotel.id);
          return hotel.toEntity().copyWith(isFavorite: isFavorite);
        }).toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _mockHotelsDataSource.ge_tHotels()).called(1);
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
        when(() => _mockHotelsDataSource.ge_tHotels())
            .thenAnswer((_) async => _tHotelModelsList);

        when(() => _mockLocalDatabase.getAllFavoriteHotelIds())
            .thenReturn(tFavoriteIds);

        final result = await _hotelRepoImpl.ge_tHotels();

        final expectedHotels = _tHotelModelsList.map((hotel) {
          final isFavorite = tFavoriteIds.contains(hotel.id);
          return hotel.toEntity().copyWith(isFavorite: isFavorite);
        }).toList();

        expect(result.getOrElse(() => []), equals(expectedHotels));
        verify(() => _mockHotelsDataSource.ge_tHotels()).called(1);
        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
        verifyNoMoreInteractions(_mockHotelsDataSource);
      },
    );

    test(
      'should return [ApiFailure] when '
      'an exception is thrown while fetching hotels from the API',
      () async {
        when(() => _mockHotelsDataSource.ge_tHotels()).thenThrow(
          const ApiException(
            message: 'Bad Request',
            statusCode: 400,
          ),
        );

        final result = await _hotelRepoImpl.ge_tHotels();

        expect(
          result,
          equals(
            const Left<ApiFailure, List<Hotel>>(
              ApiFailure(message: 'Bad Request', statusCode: 400),
            ),
          ),
        );

        verify(() => _mockHotelsDataSource.ge_tHotels()).called(1);
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
                message: 'Failed to fetch hotel ids: '
                    'DatabaseException(Database Error)',
              ),
            ),
          ),
        );

        verify(() => _mockLocalDatabase.getAllFavoriteHotelIds()).called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
      },
    );

    group('addFavoriteHotel', () {
      const _tHotel = Hotel(
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
          when(() => _mockLocalDatabase.addFavoriteHotelId(hotelId: _tHotel.id))
              .thenAnswer((_) async => Future.value());

          final result = await _hotelRepoImpl.addFavoriteHotel(hotel: _tHotel);

          expect(result, equals(const Right<Failure, void>(null)));
          verify(
            () => _mockLocalDatabase.addFavoriteHotelId(hotelId: _tHotel.id),
          ).called(1);
          verifyNoMoreInteractions(_mockLocalDatabase);
        },
      );
      test(
        'should return [DatabaseFailure] '
        'when an exception is thrown while adding a favorite hotel',
        () async {
          when(() => _mockLocalDatabase.addFavoriteHotelId(hotelId: _tHotel.id))
              .thenThrow(const DatabaseException(message: 'Database Error'));

          final result = await _hotelRepoImpl.addFavoriteHotel(hotel: _tHotel);

          expect(
            result,
            equals(
              const Left<DatabaseFailure, void>(
                DatabaseFailure(
                  message: 'Failed to add favorite hotel: '
                      'DatabaseException(Database Error)',
                ),
              ),
            ),
          );

          verify(
            () => _mockLocalDatabase.addFavoriteHotelId(hotelId: _tHotel.id),
          ).called(1);
          verifyNoMoreInteractions(_mockLocalDatabase);
        },
      );
    });
  });
  group('removeFavoriteHotelId', () {
    const _tHotelId = '123';

    test(
      'should remove a favorite hotel ID successfully and return Right(null)',
      () async {
        when(() => _mockLocalDatabase.removeFavoriteHotelId(id: _tHotelId))
            .thenAnswer((_) async => Future.value());

        final result =
            await _hotelRepoImpl.removeFavoriteHotelId(id: _tHotelId);

        expect(result, equals(const Right<Failure, void>(null)));
        verify(() => _mockLocalDatabase.removeFavoriteHotelId(id: _tHotelId))
            .called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
      },
    );

    test(
      'should return [DatabaseFailure] '
      'when an exception is thrown while removing a favorite hotel ID',
      () async {
        when(() => _mockLocalDatabase.removeFavoriteHotelId(id: _tHotelId))
            .thenThrow(Exception('Some Database Error'));

        final result =
            await _hotelRepoImpl.removeFavoriteHotelId(id: _tHotelId);

        expect(
          result,
          equals(
            const Left<Failure, void>(
              DatabaseFailure(
                message: 'Failed to add favorite hotel: Exception: '
                    'Some Database Error',
              ),
            ),
          ),
        );
        verify(() => _mockLocalDatabase.removeFavoriteHotelId(id: _tHotelId))
            .called(1);
        verifyNoMoreInteractions(_mockLocalDatabase);
      },
    );
  });
}
