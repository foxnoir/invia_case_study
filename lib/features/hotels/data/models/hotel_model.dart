import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required super.id,
    required super.name,
    required super.category,
    required super.destination,
    required super.bestOffer,
    required super.ratingInfo,
    required super.hotelId,
    List<HotelImageModel> images = const [],
  }) : super(images: images);
  const HotelModel.empty()
      : this(
          id: '',
          name: '',
          category: 0,
          destination: '',
          bestOffer: const BestOfferModel.empty(),
          ratingInfo: const RatingInfoModel.empty(),
          hotelId: '',
          images: const [],
        );

  factory HotelModel.fromMap(DataMap map) {
    return HotelModel(
      id: map['hotel-id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      category: map['category'] as int? ?? 0,
      destination: map['destination'] as String? ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((image) => HotelImageModel.fromMap(image as DataMap))
              .toList() ??
          const [],
      bestOffer: BestOfferModel.fromMap(map['best-offer'] as DataMap? ?? {}),
      ratingInfo: RatingInfoModel.fromMap(map['rating-info'] as DataMap? ?? {}),
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
          images.map((image) => (image as HotelImageModel).toMap()).toList(),
      'best-offer': (bestOffer as BestOfferModel).toMap(),
      'rating-info': (ratingInfo as RatingInfoModel).toMap(),
    };
  }

  Hotel toEntity() {
    return Hotel(
      id: id,
      name: name,
      category: category,
      destination: destination,
      images:
          images.map((image) => (image as HotelImageModel).toEntity()).toList(),
      bestOffer: (bestOffer as BestOfferModel).toEntity(),
      ratingInfo: (ratingInfo as RatingInfoModel).toEntity(),
      hotelId: hotelId,
    );
  }
}

class BestOfferModel extends BestOffer {
  const BestOfferModel({
    required super.total,
    required super.simplePricePerPerson,
    required super.flightIncluded,
    required super.travelDate,
    required super.roomGroups,
    required super.overallRoomDetails,
  });
  const BestOfferModel.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const TravelDateModel.empty(),
          roomGroups: const [],
          overallRoomDetails: const RoomDetailsModel.empty(),
        );

  factory BestOfferModel.fromMap(DataMap map) {
    final rooms = map['rooms'] as DataMap? ?? {};
    final roomGroups = rooms['room-groups'] as List<dynamic>? ?? [];
    final overall = rooms['overall'] as DataMap? ?? {};

    return BestOfferModel(
      total: map['total'] as int? ?? 0,
      simplePricePerPerson: map['simple-price-per-person'] as int? ?? 0,
      flightIncluded: map['flight-included'] as bool? ?? false,
      travelDate: TravelDateModel.fromMap(map['travel-date'] as DataMap? ?? {}),
      roomGroups: roomGroups
          .map((group) => RoomGroupModel.fromMap(group as DataMap))
          .toList(),
      overallRoomDetails: RoomDetailsModel.fromMap(overall),
    );
  }

  DataMap toMap() {
    return {
      'total': total,
      'simple-price-per-person': simplePricePerPerson,
      'flight-included': flightIncluded,
      'travel-date': (travelDate as TravelDateModel).toMap(),
      'room-groups':
          roomGroups.map((group) => (group as RoomGroupModel).toMap()).toList(),
      'overall': (overallRoomDetails as RoomDetailsModel).toMap(),
    };
  }

  BestOffer toEntity() {
    return BestOffer(
      total: total,
      simplePricePerPerson: simplePricePerPerson,
      flightIncluded: flightIncluded,
      travelDate: (travelDate as TravelDateModel).toEntity(),
      roomGroups: roomGroups
          .map((group) => (group as RoomGroupModel).toEntity())
          .toList(),
      overallRoomDetails: (overallRoomDetails as RoomDetailsModel).toEntity(),
    );
  }
}

class RoomGroupModel extends RoomGroup {
  const RoomGroupModel({
    required super.name,
    required super.boarding,
  });

  factory RoomGroupModel.fromMap(DataMap map) {
    return RoomGroupModel(
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

class RoomDetailsModel extends RoomDetails {
  const RoomDetailsModel({
    required super.name,
    required super.boarding,
    required super.adultCount,
    required super.childrenCount,
  });
  const RoomDetailsModel.empty()
      : this(
          name: '',
          boarding: '',
          adultCount: 0,
          childrenCount: 0,
        );

  factory RoomDetailsModel.fromMap(DataMap map) {
    return RoomDetailsModel(
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

class TravelDateModel extends TravelDate {
  const TravelDateModel({
    required super.days,
    required super.nights,
  });

  const TravelDateModel.empty() : super.empty();

  factory TravelDateModel.fromMap(DataMap map) {
    return TravelDateModel(
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

class RatingInfoModel extends RatingInfo {
  const RatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });
  const RatingInfoModel.empty()
      : this(
          score: 0,
          scoreDescription: '',
          reviewsCount: 0,
        );

  factory RatingInfoModel.fromMap(DataMap map) {
    return RatingInfoModel(
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

class HotelImageModel extends HotelImage {
  const HotelImageModel({
    required super.large,
    required super.small,
  });

  factory HotelImageModel.fromMap(DataMap map) {
    return HotelImageModel(
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
