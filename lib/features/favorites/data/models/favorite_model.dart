import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel({
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
    required super.favoriteId,
    List<FavoriteImageModel> images = const [],
  }) : super(images: images);

  factory FavoriteModel.fromMap(DataMap map) {
    return FavoriteModel(
      id: map['favorite-id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
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
      analytics:
          FavoriteAnalyticsModel.fromMap(map['analytics'] as DataMap? ?? {}),
      badges: (map['badges'] as List<dynamic>?)?.cast<String>() ?? const [],
      categoryType: map['category-type'] as String? ?? '',
      favoriteId: map['favorite-id'] as String? ?? '',
    );
  }

  DataMap toMap() {
    return {
      'favorite-id': favoriteId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'destination': destination,
      'images': (images as List<FavoriteImageModel>)
          .map((image) => image.toMap())
          .toList(),
      'best-offer': (bestOffer as FavoriteBestOfferModel).toMap(),
      'rating-info': (ratingInfo as FavoriteRatingInfoModel).toMap(),
      'analytics': (analytics as FavoriteAnalyticsModel).toMap(),
      'badges': badges,
      'category-type': categoryType,
    };
  }

  Favorite toEntity() {
    return Favorite(
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
      favoriteId: favoriteId,
    );
  }
}

class FavoriteAnalyticsModel extends FavoriteAnalytics {
  const FavoriteAnalyticsModel({
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

  factory FavoriteAnalyticsModel.fromMap(DataMap map) {
    final selectItem = map['select_item.item.0'] as DataMap? ?? {};
    return FavoriteAnalyticsModel(
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

class FavoriteBestOfferModel extends FavoriteBestOffer {
  const FavoriteBestOfferModel({
    required super.total,
    required super.travelPrice,
    required super.flightIncluded,
    required super.travelDate,
  });

  factory FavoriteBestOfferModel.fromMap(DataMap map) {
    return FavoriteBestOfferModel(
      total: map['total'] as int? ?? 0,
      travelPrice: map['travel-price'] as int? ?? 0,
      flightIncluded: map['flight-included'] as bool? ?? false,
      travelDate:
          FavoriteTravelDateModel.fromMap(map['travel-date'] as DataMap? ?? {}),
    );
  }

  DataMap toMap() {
    return {
      'total': total,
      'travel-price': travelPrice,
      'flight-included': flightIncluded,
      'travel-date': (travelDate as FavoriteTravelDateModel).toMap(),
    };
  }
}

class FavoriteTravelDateModel extends FavoriteTravelDate {
  const FavoriteTravelDateModel({
    required super.days,
    required super.departureDate,
    required super.nights,
    required super.returnDate,
  });

  const FavoriteTravelDateModel.empty() : super.empty();

  factory FavoriteTravelDateModel.fromMap(DataMap map) {
    return FavoriteTravelDateModel(
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

class FavoriteRatingInfoModel extends FavoriteRatingInfo {
  const FavoriteRatingInfoModel({
    required super.score,
    required super.scoreDescription,
    required super.reviewsCount,
  });

  const FavoriteRatingInfoModel.empty() : super.empty();

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
}

class FavoriteImageModel extends FavoriteImage {
  const FavoriteImageModel({
    required super.large,
    required super.small,
  });

  const FavoriteImageModel.empty() : super.empty();

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
}
