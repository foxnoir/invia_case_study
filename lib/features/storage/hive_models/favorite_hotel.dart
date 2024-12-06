import 'package:hive/hive.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

part 'favorite_hotel.g.dart';

@HiveType(typeId: 0)
class FavoriteHotel extends HiveObject {
  FavoriteHotel({
    required this.id,
    required this.name,
    required this.category,
    required this.destination,
    required this.images,
    required this.bestOffer,
    required this.ratingInfo,
    required this.hotelId,
    required this.analytics,
    required this.isFavorite,
  });

  factory FavoriteHotel.fromHotelModel(HotelModel hotel) {
    return FavoriteHotel(
      id: hotel.id,
      name: hotel.name,
      category: hotel.category,
      destination: hotel.destination,
      images: hotel.images
          .map((e) => FavoriteHotelImageHive.fromModel(e as HotelImageModel))
          .toList(),
      bestOffer: BestOfferHive.fromModel(hotel.bestOffer as BestOfferModel),
      ratingInfo: RatingInfoHive.fromModel(hotel.ratingInfo as RatingInfoModel),
      hotelId: hotel.hotelId,
      analytics: AnalyticsHive.fromModel(hotel.analytics as AnalyticsModel),
      isFavorite: hotel.isFavorite,
    );
  }

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int category;

  @HiveField(3)
  final String destination;

  @HiveField(4)
  final List<FavoriteHotelImageHive> images;

  @HiveField(5)
  final BestOfferHive bestOffer;

  @HiveField(6)
  final RatingInfoHive ratingInfo;

  @HiveField(7)
  final String hotelId;

  @HiveField(8)
  final AnalyticsHive analytics;

  @HiveField(9)
  final bool isFavorite;

  HotelModel toHotelModel() {
    return HotelModel(
      id: id,
      name: name,
      category: category,
      destination: destination,
      images: images.map((e) => e.toModel()).toList(),
      bestOffer: bestOffer.toModel(),
      ratingInfo: ratingInfo.toModel(),
      hotelId: hotelId,
      analytics: analytics.toModel(),
    );
  }
}

@HiveType(typeId: 1)
class FavoriteHotelImageHive {
  const FavoriteHotelImageHive({
    required this.large,
    required this.small,
  });

  factory FavoriteHotelImageHive.fromModel(HotelImageModel model) {
    return FavoriteHotelImageHive(
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
    required this.simplePricePerPerson,
    required this.flightIncluded,
    required this.travelDate,
    required this.roomGroups,
  });

  factory BestOfferHive.fromModel(BestOfferModel model) {
    return BestOfferHive(
      total: model.total,
      simplePricePerPerson: model.simplePricePerPerson,
      flightIncluded: model.flightIncluded,
      travelDate: TravelDateHive.fromModel(model.travelDate as TravelDateModel),
      roomGroups: model.roomGroups.map(RoomGroupHive.fromModel).toList(),
    );
  }

  @HiveField(0)
  final int total;

  @HiveField(1)
  final int simplePricePerPerson;

  @HiveField(2)
  final bool flightIncluded;

  @HiveField(3)
  final TravelDateHive travelDate;

  @HiveField(4)
  final List<RoomGroupHive> roomGroups;

  BestOfferModel toModel() {
    return BestOfferModel(
      total: total,
      simplePricePerPerson: simplePricePerPerson,
      flightIncluded: flightIncluded,
      travelDate: travelDate.toModel(),
      roomGroups: roomGroups.map((group) => group.toModel()).toList(),
    );
  }
}

@HiveType(typeId: 3)
class TravelDateHive {
  const TravelDateHive({
    required this.days,
    required this.nights,
  });

  factory TravelDateHive.fromModel(TravelDateModel model) {
    return TravelDateHive(
      days: model.days,
      nights: model.nights,
    );
  }

  @HiveField(0)
  final int days;

  @HiveField(1)
  final int nights;

  TravelDateModel toModel() {
    return TravelDateModel(
      days: days,
      nights: nights,
    );
  }
}

@HiveType(typeId: 4)
class RoomGroupHive {
  const RoomGroupHive({
    required this.name,
    required this.boarding,
  });

  factory RoomGroupHive.fromModel(RoomGroup model) {
    return RoomGroupHive(
      name: model.name,
      boarding: model.boarding,
    );
  }

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String boarding;

  RoomGroup toModel() {
    return RoomGroup(
      name: name,
      boarding: boarding,
    );
  }
}

@HiveType(typeId: 5)
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

@HiveType(typeId: 6)
class AnalyticsHive {
  const AnalyticsHive({
    required this.currency,
    required this.itemCategory,
    required this.itemId,
    required this.itemListName,
    required this.itemName,
    required this.itemRooms,
    required this.price,
  });

  factory AnalyticsHive.fromModel(AnalyticsModel model) {
    return AnalyticsHive(
      currency: model.currency,
      itemCategory: model.itemCategory,
      itemId: model.itemId,
      itemListName: model.itemListName,
      itemName: model.itemName,
      itemRooms: model.itemRooms,
      price: model.price,
    );
  }

  @HiveField(0)
  final String currency;

  @HiveField(1)
  final String itemCategory;

  @HiveField(2)
  final String itemId;

  @HiveField(3)
  final String itemListName;

  @HiveField(4)
  final String itemName;

  @HiveField(5)
  final String itemRooms;

  @HiveField(6)
  final String price;

  AnalyticsModel toModel() {
    return AnalyticsModel(
      currency: currency,
      itemCategory: itemCategory,
      itemId: itemId,
      itemListName: itemListName,
      itemName: itemName,
      itemRooms: itemRooms,
      price: price,
    );
  }
}
