import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class FavoriteModel extends Hotel {
  const FavoriteModel({
    required super.id,
    required super.name,
    required super.category,
    required super.destination,
    required super.bestOffer,
    required super.ratingInfo,
    required super.hotelId,
    List<FavoriteImageModel> images = const [],
  }) : super(images: images);

  factory FavoriteModel.fromMap(DataMap map) {
    return FavoriteModel(
      id: map['hotel-id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      category: map['category'] as int? ?? 0,
      destination: map['destination'] as String? ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((image) => FavoriteImageModel.fromMap(image as DataMap))
              .toList() ??
          const [],
      bestOffer:
          FavoriteBestOfferModel.fromMap(map['best-offer'] as DataMap? ?? {}),
      ratingInfo:
          FavoriteRatingInfoModel.fromMap(map['rating-info'] as DataMap? ?? {}),
      hotelId: map['hotel-id'] as String? ?? '',
    );
  }

  DataMap toMap() {
    return {
      'hotel-id': hotelId,
      'name': name,
      'category': category,
      'destination': destination,
      'images':
          images.map((image) => (image as FavoriteImageModel).toMap()).toList(),
      'best-offer': (bestOffer as FavoriteBestOfferModel).toMap(),
      'rating-info': (ratingInfo as FavoriteRatingInfoModel).toMap(),
    };
  }

  Hotel toEntity() {
    return Hotel(
      id: id,
      name: name,
      category: category,
      destination: destination,
      images: images
          .map((image) => (image as FavoriteImageModel).toEntity())
          .toList(),
      bestOffer: (bestOffer as FavoriteBestOfferModel).toEntity(),
      ratingInfo: (ratingInfo as FavoriteRatingInfoModel).toEntity(),
      hotelId: hotelId,
    );
  }
}

class FavoriteBestOfferModel extends BestOffer {
  const FavoriteBestOfferModel({
    required super.total,
    required super.simplePricePerPerson,
    required super.flightIncluded,
    required super.travelDate,
    required super.roomGroups,
    required super.overallRoomDetails,
  });

  factory FavoriteBestOfferModel.fromMap(DataMap map) {
    final rooms = map['rooms'] as DataMap? ?? {};
    final roomGroups = rooms['room-groups'] as List<dynamic>? ?? [];
    final overall = rooms['overall'] as DataMap? ?? {};

    return FavoriteBestOfferModel(
      total: map['total'] as int? ?? 0,
      simplePricePerPerson: map['simple-price-per-person'] as int? ?? 0,
      flightIncluded: map['flight-included'] as bool? ?? false,
      travelDate:
          FavoriteTravelDateModel.fromMap(map['travel-date'] as DataMap? ?? {}),
      roomGroups: roomGroups
          .map((group) => FavoriteRoomGroupModel.fromMap(group as DataMap))
          .toList(),
      overallRoomDetails: FavoriteRoomDetailsModel.fromMap(overall),
    );
  }

  DataMap toMap() {
    return {
      'total': total,
      'simple-price-per-person': simplePricePerPerson,
      'flight-included': flightIncluded,
      'travel-date': (travelDate as FavoriteTravelDateModel).toMap(),
      'room-groups': roomGroups
          .map((group) => (group as FavoriteRoomGroupModel).toMap())
          .toList(),
      'overall': (overallRoomDetails as FavoriteRoomDetailsModel).toMap(),
    };
  }

  BestOffer toEntity() {
    return BestOffer(
      total: total,
      simplePricePerPerson: simplePricePerPerson,
      flightIncluded: flightIncluded,
      travelDate: (travelDate as FavoriteTravelDateModel).toEntity(),
      roomGroups: roomGroups
          .map((group) => (group as FavoriteRoomGroupModel).toEntity())
          .toList(),
      overallRoomDetails:
          (overallRoomDetails as FavoriteRoomDetailsModel).toEntity(),
    );
  }
}

class FavoriteRoomGroupModel extends RoomGroup {
  const FavoriteRoomGroupModel({
    required super.name,
    required super.boarding,
  });

  factory FavoriteRoomGroupModel.fromMap(DataMap map) {
    return FavoriteRoomGroupModel(
      name: map['name'] as String? ?? '',
      boarding: map['boarding'] as String? ?? '',
    );
  }

  DataMap toMap() {
    return {
      'name': name,
      'boarding': boarding,
    };
  }

  RoomGroup toEntity() {
    return RoomGroup(
      name: name,
      boarding: boarding,
    );
  }
}

class FavoriteRoomDetailsModel extends RoomDetails {
  const FavoriteRoomDetailsModel({
    required super.name,
    required super.boarding,
    required super.adultCount,
    required super.childrenCount,
  });

  factory FavoriteRoomDetailsModel.fromMap(DataMap map) {
    return FavoriteRoomDetailsModel(
      name: map['name'] as String? ?? '',
      boarding: map['boarding'] as String? ?? '',
      adultCount: map['adult-count'] as int? ?? 0,
      childrenCount: map['children-count'] as int? ?? 0,
    );
  }

  DataMap toMap() {
    return {
      'name': name,
      'boarding': boarding,
      'adult-count': adultCount,
      'children-count': childrenCount,
    };
  }

  RoomDetails toEntity() {
    return RoomDetails(
      name: name,
      boarding: boarding,
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}

class FavoriteTravelDateModel extends TravelDate {
  const FavoriteTravelDateModel({
    required super.days,
    required super.nights,
  });

  const FavoriteTravelDateModel.empty() : super.empty();

  factory FavoriteTravelDateModel.fromMap(DataMap map) {
    return FavoriteTravelDateModel(
      days: map['days'] as int? ?? 0,
      nights: map['nights'] as int? ?? 0,
    );
  }

  DataMap toMap() {
    return {
      'days': days,
      'nights': nights,
    };
  }

  TravelDate toEntity() {
    return TravelDate(
      days: days,
      nights: nights,
    );
  }
}

class FavoriteRatingInfoModel extends RatingInfo {
  const FavoriteRatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });

  factory FavoriteRatingInfoModel.fromMap(DataMap map) {
    return FavoriteRatingInfoModel(
      score: (map['score'] as num?)?.toDouble() ?? 0.0,
      scoreDescription: map['score-description'] as String? ?? '',
      reviewsCount: map['reviews-count'] as int? ?? 0,
    );
  }

  DataMap toMap() {
    return {
      'score': score,
      'score-description': scoreDescription,
      'reviews-count': reviewsCount,
    };
  }

  RatingInfo toEntity() {
    return RatingInfo(
      score: score,
      scoreDescription: scoreDescription,
      reviewsCount: reviewsCount,
    );
  }
}

class FavoriteImageModel extends HotelImage {
  const FavoriteImageModel({
    required super.large,
    required super.small,
  });

  factory FavoriteImageModel.fromMap(DataMap map) {
    return FavoriteImageModel(
      large: map['large'] as String? ?? '',
      small: map['small'] as String? ?? '',
    );
  }

  DataMap toMap() {
    return {
      'large': large,
      'small': small,
    };
  }

  HotelImage toEntity() {
    return HotelImage(
      large: large,
      small: small,
    );
  }
}
