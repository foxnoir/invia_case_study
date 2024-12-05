import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';

class Hotel extends Equatable {
  const Hotel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.destination,
    required this.bestOffer,
    required this.ratingInfo,
    required this.analytics,
    required this.badges,
    required this.categoryType,
    required this.hotelId,
    this.images = const [],
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int category;
  final String destination;
  final List<HotelImage> images;
  final BestOffer bestOffer;
  final RatingInfo ratingInfo;
  final Analytics analytics;
  final List<String> badges;
  final String categoryType;
  final String hotelId;
  final bool isFavorite;

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        category,
        destination,
        images,
        bestOffer,
        ratingInfo,
        analytics,
        badges,
        categoryType,
        hotelId,
        isFavorite,
      ];

  /// Erzeugt eine neue Instanz von `Hotel` mit aktualisierten Werten.
  Hotel copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    int? category,
    String? destination,
    List<HotelImage>? images,
    BestOffer? bestOffer,
    RatingInfo? ratingInfo,
    Analytics? analytics,
    List<String>? badges,
    String? categoryType,
    String? hotelId,
    bool? isFavorite,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      destination: destination ?? this.destination,
      images: images ?? this.images,
      bestOffer: bestOffer ?? this.bestOffer,
      ratingInfo: ratingInfo ?? this.ratingInfo,
      analytics: analytics ?? this.analytics,
      badges: badges ?? this.badges,
      categoryType: categoryType ?? this.categoryType,
      hotelId: hotelId ?? this.hotelId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Analytics extends Equatable {
  const Analytics({
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

  const Analytics.empty()
      : this(
          currency: '',
          itemCategory: '',
          itemCategory2: '',
          itemId: '',
          itemListName: '',
          itemName: '',
          itemRooms: '',
          price: '',
          quantity: 0,
        );

  final String currency;
  final String itemCategory;
  final String itemCategory2;
  final String itemId;
  final String itemListName;
  final String itemName;
  final String itemRooms;
  final String price;
  final int quantity;

  @override
  List<Object?> get props => [
        currency,
        itemCategory,
        itemCategory2,
        itemId,
        itemListName,
        itemName,
        itemRooms,
        price,
        quantity,
      ];

  @override
  String toString() {
    return 'Analytics{currency: $currency, itemCategory: $itemCategory, '
        'itemCategory2: $itemCategory2, itemId: $itemId, '
        'itemListName: $itemListName, itemName: $itemName, '
        'itemRooms: $itemRooms, price: $price, quantity: $quantity}';
  }
}

class HotelImage extends Equatable {
  const HotelImage({
    required this.large,
    required this.small,
  });

  const HotelImage.empty()
      : this(
          large: '',
          small: '',
        );

  final String large;
  final String small;

  @override
  List<Object?> get props => [large, small];

  @override
  String toString() {
    return 'HotelImage{large: $large, small: $small}';
  }
}

class BestOffer extends Equatable {
  const BestOffer({
    required this.total,
    required this.travelPrice,
    required this.flightIncluded,
    required this.travelDate,
  });

  const BestOffer.empty()
      : this(
          total: 0,
          travelPrice: 0,
          flightIncluded: false,
          travelDate: const TravelDate.empty(),
        );

  final int total;
  final int travelPrice;
  final bool flightIncluded;
  final TravelDate travelDate;

  @override
  List<Object?> get props => [
        total,
        travelPrice,
        flightIncluded,
        travelDate,
      ];

  @override
  String toString() {
    return 'BestOffer{total: $total, travelPrice: $travelPrice, '
        'flightIncluded: $flightIncluded, travelDate: $travelDate}';
  }
}

class TravelDate extends Equatable {
  const TravelDate({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });

  const TravelDate.empty()
      : this(
          days: 0,
          departureDate: '',
          nights: 0,
          returnDate: '',
        );

  final int days;
  final String departureDate;
  final int nights;
  final String returnDate;

  @override
  List<Object?> get props => [
        days,
        departureDate,
        nights,
        returnDate,
      ];

  @override
  String toString() {
    return 'TravelDate{days: $days, departureDate: $departureDate, '
        'nights: $nights, returnDate: $returnDate}';
  }
}

class RatingInfo extends Equatable {
  const RatingInfo({
    required this.score,
    required this.scoreDescription,
    required this.reviewsCount,
  });

  const RatingInfo.empty()
      : this(
          score: 0,
          scoreDescription: '',
          reviewsCount: 0,
        );

  final double score;
  final String scoreDescription;
  final int reviewsCount;

  @override
  List<Object?> get props => [score, scoreDescription, reviewsCount];

  @override
  String toString() {
    return 'RatingInfo{score: $score, scoreDescription: $scoreDescription, '
        'reviewsCount: $reviewsCount}';
  }
}

extension HotelMapper on Hotel {
  FavoriteHotel toFavoriteHotel() {
    return FavoriteHotel(
      id: id,
      isFavorite: true,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      destination: destination,
      images: images
          .map(
            (image) => FavoriteHotelImageHive(
              large: image.large,
              small: image.small,
            ),
          )
          .toList(),
      bestOffer: BestOfferHive(
        total: bestOffer.total,
        travelPrice: bestOffer.travelPrice,
        flightIncluded: bestOffer.flightIncluded,
        travelDate: TravelDateHive(
          days: bestOffer.travelDate.days,
          departureDate: bestOffer.travelDate.departureDate,
          nights: bestOffer.travelDate.nights,
          returnDate: bestOffer.travelDate.returnDate,
        ),
      ),
      ratingInfo: RatingInfoHive(
        score: ratingInfo.score,
        scoreDescription: ratingInfo.scoreDescription,
        reviewsCount: ratingInfo.reviewsCount,
      ),
      badges: badges,
      categoryType: categoryType,
      hotelId: hotelId,
      analytics: AnalyticsHive(
        currency: analytics.currency,
        itemCategory: analytics.itemCategory,
        itemCategory2: analytics.itemCategory2,
        itemId: analytics.itemId,
        itemListName: analytics.itemListName,
        itemName: analytics.itemName,
        itemRooms: analytics.itemRooms,
        price: analytics.price,
        quantity: analytics.quantity,
      ),
    );
  }
}
