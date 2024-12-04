import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.category,
    required super.destination,
    required BestOfferModel bestOffer,
    required RatingInfoModel ratingInfo,
    List<HotelImageModel> images = const [],
  }) : super(
          bestOffer: bestOffer,
          ratingInfo: ratingInfo,
          images: images,
        );

  const HotelModel.empty()
      : this(
          id: '',
          name: '',
          latitude: 0,
          longitude: 0,
          category: 0,
          destination: '',
          images: const [],
          bestOffer: const BestOfferModel.empty(),
          ratingInfo: const RatingInfoModel.empty(),
        );

  factory HotelModel.fromMap(DataMap map) {
    return HotelModel(
      id: map['hotel-id'] as String,
      name: map['name'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      category: map['category'] as int,
      destination: map['destination'] as String,
      images: (map['images'] as List)
          .map((image) => HotelImageModel.fromMap(image as DataMap))
          .toList(),
      bestOffer: BestOfferModel.fromMap(map['best-offer'] as DataMap),
      ratingInfo: RatingInfoModel.fromMap(map['rating-info'] as DataMap),
    );
  }

  DataMap toMap() {
    return {
      'hotel-id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'destination': destination,
      'images': (images as List<HotelImageModel>)
          .map((image) => image.toMap())
          .toList(),
      'best-offer': (bestOffer as BestOfferModel).toMap(),
      'rating-info': (ratingInfo as RatingInfoModel).toMap(),
    };
  }

  HotelModel copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    int? category,
    String? destination,
    List<HotelImageModel>? images,
    BestOfferModel? bestOffer,
    RatingInfoModel? ratingInfo,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      destination: destination ?? this.destination,
      images: images ?? this.images.cast<HotelImageModel>(),
      bestOffer: bestOffer ?? this.bestOffer as BestOfferModel,
      ratingInfo: ratingInfo ?? this.ratingInfo as RatingInfoModel,
    );
  }
}

class BestOfferModel extends BestOffer {
  const BestOfferModel({
    required super.total,
    required super.travelPrice,
    required super.flightIncluded,
    required super.travelDate,
  });

  const BestOfferModel.empty() : super.empty();

  factory BestOfferModel.fromMap(DataMap map) {
    return BestOfferModel(
      total: map['total'] as int,
      travelPrice: map['travel-price'] as int,
      flightIncluded: map['flight-included'] as bool,
      travelDate: TravelDateModel.fromMap(map['travel-date'] as DataMap),
    );
  }

  DataMap toMap() {
    return {
      'total': total,
      'travel-price': travelPrice,
      'flight-included': flightIncluded,
      'travel-date': (travelDate as TravelDateModel).toMap(),
    };
  }
}

class TravelDateModel extends TravelDate {
  const TravelDateModel({
    required super.days,
    required super.departureDate,
    required super.nights,
    required super.returnDate,
  });

  const TravelDateModel.empty() : super.empty();

  factory TravelDateModel.fromMap(DataMap map) {
    return TravelDateModel(
      days: map['days'] as int,
      departureDate: map['departure-date'] as String,
      nights: map['nights'] as int,
      returnDate: map['return-date'] as String,
    );
  }

  DataMap toMap() {
    return {
      'days': days,
      'departure-date': departureDate,
      'nights': nights,
      'return-date': returnDate,
    };
  }
}

class RatingInfoModel extends RatingInfo {
  const RatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });

  const RatingInfoModel.empty() : super.empty();

  factory RatingInfoModel.fromMap(DataMap map) {
    return RatingInfoModel(
      score: (map['score'] as num).toDouble(),
      scoreDescription: map['score-description'] as String,
      reviewsCount: map['reviews-count'] as int,
    );
  }

  DataMap toMap() {
    return {
      'score': score,
      'score-description': scoreDescription,
      'reviews-count': reviewsCount,
    };
  }
}

class HotelImageModel extends HotelImage {
  const HotelImageModel({
    required super.large,
    required super.small,
  });

  const HotelImageModel.empty() : super.empty();

  factory HotelImageModel.fromMap(DataMap map) {
    return HotelImageModel(
      large: map['large'] as String,
      small: map['small'] as String,
    );
  }

  DataMap toMap() {
    return {
      'large': large,
      'small': small,
    };
  }
}
