import 'package:hive/hive.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';

part 'favorite_hotel.g.dart';

@HiveType(typeId: 0)
class FavoriteHotel extends HiveObject {
  FavoriteHotel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.destination,
    required this.images,
    required this.bestOffer,
    required this.ratingInfo,
    required this.badges,
    required this.categoryType,
    required this.hotelId,
    required this.analytics,
  });

  factory FavoriteHotel.fromHotelModel(HotelModel hotel) {
    return FavoriteHotel(
      id: hotel.id,
      name: hotel.name,
      latitude: hotel.latitude,
      longitude: hotel.longitude,
      category: hotel.category,
      destination: hotel.destination,
      images: hotel.images
          .map((e) => HotelImageHive.fromModel(e as HotelImageModel))
          .toList(),
      bestOffer: BestOfferHive.fromModel(hotel.bestOffer as BestOfferModel),
      ratingInfo: RatingInfoHive.fromModel(hotel.ratingInfo as RatingInfoModel),
      badges: hotel.badges,
      categoryType: hotel.categoryType,
      hotelId: hotel.hotelId,
      analytics: AnalyticsHive.fromModel(hotel.analytics as AnalyticsModel),
    );
  }

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final int category;

  @HiveField(5)
  final String destination;

  @HiveField(6)
  final List<HotelImageHive> images;

  @HiveField(7)
  final BestOfferHive bestOffer;

  @HiveField(8)
  final RatingInfoHive ratingInfo;

  @HiveField(9)
  final List<String> badges;

  @HiveField(10)
  final String categoryType;

  @HiveField(11)
  final String hotelId;

  @HiveField(12)
  final AnalyticsHive analytics;

  HotelModel toHotelModel() {
    return HotelModel(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      destination: destination,
      images: images.map((e) => e.toModel()).toList(),
      bestOffer: bestOffer.toModel(),
      ratingInfo: ratingInfo.toModel(),
      badges: badges,
      categoryType: categoryType,
      hotelId: hotelId,
      analytics: analytics.toModel(),
    );
  }
}

@HiveType(typeId: 1)
class HotelImageHive {
  const HotelImageHive({
    required this.large,
    required this.small,
  });

  factory HotelImageHive.fromModel(HotelImageModel model) {
    return HotelImageHive(
      large: model.large,
      small: model.small,
    );
  }

  @HiveField(0)
  final String large;

  @HiveField(1)
  final String small;

  HotelImageModel toModel() {
    return HotelImageModel(
      large: large,
      small: small,
    );
  }
}

@HiveType(typeId: 2)
class BestOfferHive {
  const BestOfferHive({
    required this.total,
    required this.travelPrice,
    required this.flightIncluded,
    required this.travelDate,
  });

  factory BestOfferHive.fromModel(BestOfferModel model) {
    return BestOfferHive(
      total: model.total,
      travelPrice: model.travelPrice,
      flightIncluded: model.flightIncluded,
      travelDate: TravelDateHive.fromModel(model.travelDate as TravelDateModel),
    );
  }

  @HiveField(0)
  final int total;

  @HiveField(1)
  final int travelPrice;

  @HiveField(2)
  final bool flightIncluded;

  @HiveField(3)
  final TravelDateHive travelDate;

  BestOfferModel toModel() {
    return BestOfferModel(
      total: total,
      travelPrice: travelPrice,
      flightIncluded: flightIncluded,
      travelDate: travelDate.toModel(),
    );
  }
}

@HiveType(typeId: 3)
class TravelDateHive {
  const TravelDateHive({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });

  factory TravelDateHive.fromModel(TravelDateModel model) {
    return TravelDateHive(
      days: model.days,
      departureDate: model.departureDate,
      nights: model.nights,
      returnDate: model.returnDate,
    );
  }

  @HiveField(0)
  final int days;

  @HiveField(1)
  final String departureDate;

  @HiveField(2)
  final int nights;

  @HiveField(3)
  final String returnDate;

  TravelDateModel toModel() {
    return TravelDateModel(
      days: days,
      departureDate: departureDate,
      nights: nights,
      returnDate: returnDate,
    );
  }
}

@HiveType(typeId: 4)
class RatingInfoHive {
  const RatingInfoHive({
    required this.score,
    required this.scoreDescription,
    required this.reviewsCount,
  });

  factory RatingInfoHive.fromModel(RatingInfoModel model) {
    return RatingInfoHive(
      score: model.score,
      scoreDescription: model.scoreDescription,
      reviewsCount: model.reviewsCount,
    );
  }

  @HiveField(0)
  final double score;

  @HiveField(1)
  final String scoreDescription;

  @HiveField(2)
  final int reviewsCount;

  RatingInfoModel toModel() {
    return RatingInfoModel(
      score: score,
      scoreDescription: scoreDescription,
      reviewsCount: reviewsCount,
    );
  }
}

@HiveType(typeId: 5)
class AnalyticsHive {
  const AnalyticsHive({
    required this.currency,
    required this.itemCategory,
    required this.itemCategory2,
    required this.itemId,
    required this.itemListName,
    required this.itemName,
    required this.itemRooms,
    required this.price,
    required this.quantity,
  });

  factory AnalyticsHive.fromModel(AnalyticsModel model) {
    return AnalyticsHive(
      currency: model.currency,
      itemCategory: model.itemCategory,
      itemCategory2: model.itemCategory2,
      itemId: model.itemId,
      itemListName: model.itemListName,
      itemName: model.itemName,
      itemRooms: model.itemRooms,
      price: model.price,
      quantity: model.quantity,
    );
  }

  @HiveField(0)
  final String currency;

  @HiveField(1)
  final String itemCategory;

  @HiveField(2)
  final String itemCategory2;

  @HiveField(3)
  final String itemId;

  @HiveField(4)
  final String itemListName;

  @HiveField(5)
  final String itemName;

  @HiveField(6)
  final String itemRooms;

  @HiveField(7)
  final String price;

  @HiveField(8)
  final int quantity;

  AnalyticsModel toModel() {
    return AnalyticsModel(
      currency: currency,
      itemCategory: itemCategory,
      itemCategory2: itemCategory2,
      itemId: itemId,
      itemListName: itemListName,
      itemName: itemName,
      itemRooms: itemRooms,
      price: price,
      quantity: quantity,
    );
  }
}
