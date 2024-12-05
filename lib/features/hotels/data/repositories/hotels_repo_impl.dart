import 'package:dartz/dartz.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';
import 'package:invia_case_study/features/storage/local_database.dart';

class HotelRepoImpl implements HotelsRepository {
  final HotelsDataSource _hotelsDataSource = DI.getIt<HotelsDataSource>();
  final LocalDatabase _localDatabase = DI.getIt<LocalDatabase>();

  @override
  ResultFuture<List<Hotel>> getHotels() async {
    try {
      final result = await _hotelsDataSource.getHotels();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addFavoriteHotel({required Hotel hotel}) async {
    try {
      final favoriteHotel = _mapHotelToFavoriteHotel(hotel);

      await _localDatabase.addFavoriteHotel(favoriteHotel: favoriteHotel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to add favorite hotel: $e'));
    }
  }

  FavoriteHotel _mapHotelToFavoriteHotel(Hotel hotel) {
    return FavoriteHotel(
      id: hotel.id,
      name: hotel.name,
      latitude: hotel.latitude,
      longitude: hotel.longitude,
      category: hotel.category,
      destination: hotel.destination,
      images: hotel.images
          .map(
            (image) => HotelImageHive(
              large: image.large,
              small: image.small,
            ),
          )
          .toList(),
      bestOffer: BestOfferHive(
        total: hotel.bestOffer.total,
        travelPrice: hotel.bestOffer.travelPrice,
        flightIncluded: hotel.bestOffer.flightIncluded,
        travelDate: TravelDateHive(
          days: hotel.bestOffer.travelDate.days,
          departureDate: hotel.bestOffer.travelDate.departureDate,
          nights: hotel.bestOffer.travelDate.nights,
          returnDate: hotel.bestOffer.travelDate.returnDate,
        ),
      ),
      ratingInfo: RatingInfoHive(
        score: hotel.ratingInfo.score,
        scoreDescription: hotel.ratingInfo.scoreDescription,
        reviewsCount: hotel.ratingInfo.reviewsCount,
      ),
      badges: hotel.badges,
      categoryType: hotel.categoryType,
      hotelId: hotel.hotelId,
      analytics: AnalyticsHive(
        currency: hotel.analytics.currency,
        itemCategory: hotel.analytics.itemCategory,
        itemCategory2: hotel.analytics.itemCategory2,
        itemId: hotel.analytics.itemId,
        itemListName: hotel.analytics.itemListName,
        itemName: hotel.analytics.itemName,
        itemRooms: hotel.analytics.itemRooms,
        price: hotel.analytics.price,
        quantity: hotel.analytics.quantity,
      ),
    );
  }
}
