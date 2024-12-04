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
    required super.bestOffer,
    required super.ratingInfo,
    required super.analytics,
    required super.badges,
    required super.categoryType,
    required super.hotelId,
    List<HotelImageModel> images = const [],
  }) : super(images: images);

  factory HotelModel.fromMap(DataMap map) {
    return HotelModel(
      id: map['hotel-id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] as int? ?? 0,
      destination: map['destination'] as String? ?? '',
      images: (map['images'] as List<dynamic>?)
              ?.map((image) => HotelImageModel.fromMap(image as DataMap))
              .toList() ??
          const [],
      bestOffer: BestOfferModel.fromMap(map['best-offer'] as DataMap? ?? {}),
      ratingInfo: RatingInfoModel.fromMap(map['rating-info'] as DataMap? ?? {}),
      analytics: AnalyticsModel.fromMap(map['analytics'] as DataMap? ?? {}),
      badges: (map['badges'] as List<dynamic>?)?.cast<String>() ?? const [],
      categoryType: map['category-type'] as String? ?? '',
      hotelId: map['hotel-id'] as String? ?? '',
    );
  }

  DataMap toMap() {
    return {
      'hotel-id': hotelId,
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
      'analytics': (analytics as AnalyticsModel).toMap(),
      'badges': badges,
      'category-type': categoryType,
    };
  }

  Hotel toEntity() {
    return Hotel(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      destination: destination,
      images: images,
      bestOffer: bestOffer,
      ratingInfo: ratingInfo,
      analytics: analytics,
      badges: badges,
      categoryType: categoryType,
      hotelId: hotelId,
    );
  }
}

class AnalyticsModel extends Analytics {
  const AnalyticsModel({
    required super.currency,
    required super.itemCategory,
    required super.itemCategory2,
    required super.itemId,
    required super.itemListName,
    required super.itemName,
    required super.itemRooms,
    required super.price,
    required super.quantity,
  });

  factory AnalyticsModel.fromMap(DataMap map) {
    final selectItem = map['select_item.item.0'] as DataMap? ?? {};
    return AnalyticsModel(
      currency: selectItem['currency'] as String? ?? '',
      itemCategory: selectItem['itemCategory'] as String? ?? '',
      itemCategory2: selectItem['itemCategory2'] as String? ?? '',
      itemId: selectItem['itemId'] as String? ?? '',
      itemListName: selectItem['itemListName'] as String? ?? '',
      itemName: selectItem['itemName'] as String? ?? '',
      itemRooms: selectItem['itemRooms'] as String? ?? '',
      price: selectItem['price'] as String? ?? '',
      quantity: int.tryParse(selectItem['quantity'] as String? ?? '0') ?? 0,
    );
  }

  DataMap toMap() {
    return {
      'select_item.item.0': {
        'currency': currency,
        'itemCategory': itemCategory,
        'itemCategory2': itemCategory2,
        'itemId': itemId,
        'itemListName': itemListName,
        'itemName': itemName,
        'itemRooms': itemRooms,
        'price': price,
        'quantity': quantity.toString(),
      },
    };
  }
}

// Supporting BestOffer Model
class BestOfferModel extends BestOffer {
  const BestOfferModel({
    required super.total,
    required super.travelPrice,
    required super.flightIncluded,
    required super.travelDate,
  });

  factory BestOfferModel.fromMap(DataMap map) {
    return BestOfferModel(
      total: map['total'] as int? ?? 0,
      travelPrice: map['travel-price'] as int? ?? 0,
      flightIncluded: map['flight-included'] as bool? ?? false,
      travelDate: TravelDateModel.fromMap(map['travel-date'] as DataMap? ?? {}),
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

// Supporting TravelDate Model
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
      days: map['days'] as int? ?? 0,
      departureDate: map['departure-date'] as String? ?? '',
      nights: map['nights'] as int? ?? 0,
      returnDate: map['return-date'] as String? ?? '',
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

// Supporting RatingInfo Model
class RatingInfoModel extends RatingInfo {
  const RatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });

  const RatingInfoModel.empty() : super.empty();

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
}

// Supporting HotelImage Model
class HotelImageModel extends HotelImage {
  const HotelImageModel({
    required super.large,
    required super.small,
  });

  const HotelImageModel.empty() : super.empty();

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
}
