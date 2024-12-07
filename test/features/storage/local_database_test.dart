import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/data/repositories/hotels_repo_impl.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';

import '../hotels/data/repositories/hotels_repo_impl_test.dart';
import 'in_memory_local_database.dart';

void main() {
  late InMemoryLocalDatabase _inMemoryLocalDatabase;
  late MockHotelsDataSource _mockHotelsDataSource;
  late HotelRepoImpl _hotelRepoImpl;

  setUp(() {
    _inMemoryLocalDatabase = InMemoryLocalDatabase();
    _mockHotelsDataSource = MockHotelsDataSource();
    _hotelRepoImpl = HotelRepoImpl(
      localDatabase: _inMemoryLocalDatabase,
      hotelsDataSource: _mockHotelsDataSource,
    );
  });

  group('Local Database', () {
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
      'should add a favorite hotel successfully and store '
      'when [HotelRepoImpl.addFavoriteHotel()] was called',
      () async {
        final result = await _hotelRepoImpl.addFavoriteHotel(hotel: tHotel);

        expect(result, equals(const Right<Failure, void>(null)));
        final storedIds = _inMemoryLocalDatabase.getAllFavoriteHotelIds();
        expect(storedIds, contains(tHotel.id));
      },
    );

    test(
      'should not add a duplicate favorite hotel ID',
      () async {
        await _hotelRepoImpl.addFavoriteHotel(hotel: tHotel);

        final result = await _hotelRepoImpl.addFavoriteHotel(hotel: tHotel);

        expect(result, equals(const Right<Failure, void>(null)));
        final storedIds = _inMemoryLocalDatabase.getAllFavoriteHotelIds();
        expect(storedIds.length, equals(1));
        expect(storedIds, contains(tHotel.id));
      },
    );

    test(
      'should add a favorite hotel successfully and store '
      'when [HotelRepoImpl.removeFavoriteHotelId()] was called',
      () async {
        const tHotelId = '123';

        await _inMemoryLocalDatabase.addFavoriteHotelId(hotelId: tHotelId);

        final result = await _hotelRepoImpl.removeFavoriteHotelId(id: tHotelId);

        expect(result, equals(const Right<Failure, void>(null)));
        final storedIds = _inMemoryLocalDatabase.getAllFavoriteHotelIds();
        expect(storedIds, isNot(contains(tHotelId)));
      },
    );

    test(
      'should handle the removal of a non-existent hotel ID gracefully',
      () async {
        final result =
            await _hotelRepoImpl.removeFavoriteHotelId(id: 'nonexistent-id');

        expect(result, equals(const Right<Failure, void>(null)));
        final storedIds = _inMemoryLocalDatabase.getAllFavoriteHotelIds();
        expect(storedIds, isEmpty);
      },
    );
  });
}
