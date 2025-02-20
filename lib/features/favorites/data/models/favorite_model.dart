import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';

class FavoriteModel extends HotelEntity {
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

  const FavoriteModel.empty()
      : this(
          id: '',
          name: '',
          category: 0,
          destination: '',
          bestOffer: const FavoriteBestOfferModel.empty(),
          ratingInfo: const FavoriteRatingInfoModel.empty(),
          hotelId: '',
          images: const [],
        );

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

  HotelEntity toEntity() {
    return HotelEntity(
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

class FavoriteBestOfferModel extends BestOfferEntity {
  const FavoriteBestOfferModel({
    required super.total,
    required super.simplePricePerPerson,
    required super.flightIncluded,
    required super.travelDate,
    required super.roomGroups,
    required super.overallRoomDetails,
  });

  const FavoriteBestOfferModel.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const FavoriteTravelDateModel.empty(),
          roomGroups: const [],
          overallRoomDetails: const FavoriteRoomDetailsModel.empty(),
        );

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

  BestOfferEntity toEntity() {
    return BestOfferEntity(
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

class FavoriteRoomGroupModel extends RoomGroupEntity {
  const FavoriteRoomGroupModel({
    required super.name,
    required super.boarding,
  });

  const FavoriteRoomGroupModel.empty()
      : this(
          name: '',
          boarding: '',
        );

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

  RoomGroupEntity toEntity() {
    return RoomGroupEntity(
      name: name,
      boarding: boarding,
    );
  }
}

class FavoriteRoomDetailsModel extends RoomDetailsEntity {
  const FavoriteRoomDetailsModel({
    required super.name,
    required super.boarding,
    required super.adultCount,
    required super.childrenCount,
  });

  const FavoriteRoomDetailsModel.empty()
      : this(
          name: '',
          boarding: '',
          adultCount: 0,
          childrenCount: 0,
        );

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

  RoomDetailsEntity toEntity() {
    return RoomDetailsEntity(
      name: name,
      boarding: boarding,
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}

class FavoriteTravelDateModel extends TravelDateEntity {
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

  TravelDateEntity toEntity() {
    return TravelDateEntity(
      days: days,
      nights: nights,
    );
  }
}

class FavoriteRatingInfoModel extends RatingInfoEntity {
  const FavoriteRatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });

  const FavoriteRatingInfoModel.empty()
      : this(
          score: 0,
          scoreDescription: '',
          reviewsCount: 0,
        );

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

  RatingInfoEntity toEntity() {
    return RatingInfoEntity(
      score: score,
      scoreDescription: scoreDescription,
      reviewsCount: reviewsCount,
    );
  }
}

class FavoriteImageModel extends HotelImageEntity {
  const FavoriteImageModel({
    required super.large,
    required super.small,
  });

  const FavoriteImageModel.empty()
      : this(
          large: '',
          small: '',
        );

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

  HotelImageEntity toEntity() {
    return HotelImageEntity(
      large: large,
      small: small,
    );
  }
}
