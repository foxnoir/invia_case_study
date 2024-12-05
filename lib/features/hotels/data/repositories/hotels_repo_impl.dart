import 'package:dartz/dartz.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/local_database.dart';

class HotelRepoImpl implements HotelsRepository {
  final HotelsDataSource _hotelsDataSource = DI.getIt<HotelsDataSource>();
  final LocalDatabase _localDatabase = DI.getIt<LocalDatabase>();

  @override
  ResultFuture<List<Hotel>> getHotels() async {
    try {
      final hotelModels = await _hotelsDataSource.getHotels();
      final hotels = hotelModels.map((model) => model.toEntity()).toList();

      final favoriteResult = getFavoriteHotelIds();
      final favoriteIds = favoriteResult.fold<List<String>>(
        (failure) {
          return [];
        },
        (ids) => ids,
      );

      final updatedHotels = hotels.map((hotel) {
        final isFavorite = favoriteIds.contains(hotel.id);
        return hotel.copyWith(isFavorite: isFavorite);
      }).toList();

      return Right(updatedHotels);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultSync<List<String>> getFavoriteHotelIds() {
    try {
      return Right(_localDatabase.getAllFavoriteHotelIds());
    } on ApiException catch (e) {
      return Left(
        DatabaseFailure(message: 'Failed to fetch hotel ids: $e'),
      );
    }
  }

  @override
  ResultFuture<void> addFavoriteHotel({required Hotel hotel}) async {
    try {
      final favoriteHotel = hotel.toFavoriteHotel();
      await _localDatabase.addFavoriteHotel(favoriteHotel: favoriteHotel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to add favorite hotel: $e'));
    }
  }

  @override
  ResultFuture<void> removeFavoriteHotelById({required String id}) async {
    try {
      await _localDatabase.removeFavoriteHotelById(id: id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to add favorite hotel: $e'));
    }
  }
}
