import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';

class Favorite extends Equatable {
  const Favorite({
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
    required this.favoriteId,
    this.images = const [],
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int category;
  final String destination;
  final List<FavoriteImage> images;
  final FavoriteBestOffer bestOffer;
  final FavoriteRatingInfo ratingInfo;
  final FavoriteAnalytics analytics;
  final List<String> badges;
  final String categoryType;
  final String favoriteId;

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
        favoriteId,
      ];
}

class FavoriteAnalytics extends Equatable {
  const FavoriteAnalytics({
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

  const FavoriteAnalytics.empty()
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
}

class FavoriteImage extends Equatable {
  const FavoriteImage({
    required this.large,
    required this.small,
  });

  const FavoriteImage.empty()
      : this(
          large: '',
          small: '',
        );

  final String large;
  final String small;

  @override
  List<Object?> get props => [large, small];
}

class FavoriteBestOffer extends Equatable {
  const FavoriteBestOffer({
    required this.total,
    required this.travelPrice,
    required this.flightIncluded,
    required this.travelDate,
  });

  const FavoriteBestOffer.empty()
      : this(
          total: 0,
          travelPrice: 0,
          flightIncluded: false,
          travelDate: const FavoriteTravelDate.empty(),
        );

  final int total;
  final int travelPrice;
  final bool flightIncluded;
  final FavoriteTravelDate travelDate;

  @override
  List<Object?> get props => [
        total,
        travelPrice,
        flightIncluded,
        travelDate,
      ];
}

class FavoriteTravelDate extends Equatable {
  const FavoriteTravelDate({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });

  const FavoriteTravelDate.empty()
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
}

class FavoriteRatingInfo extends Equatable {
  const FavoriteRatingInfo({
    required this.score,
    required this.scoreDescription,
    required this.reviewsCount,
  });

  const FavoriteRatingInfo.empty()
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
}

extension FavoriteExtension on Favorite {
  Hotel toHotel() {
    return Hotel(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      destination: destination,
      images: images
          .map((img) => HotelImage(large: img.large, small: img.small))
          .toList(),
      bestOffer: bestOffer.toHotelBestOffer(),
      ratingInfo: ratingInfo.toHotelRatingInfo(),
      badges: badges,
      categoryType: categoryType,
      hotelId: favoriteId,
      analytics: analytics.toHotelAnalytics(),
    );
  }
}

extension FavoriteBestOfferExtension on FavoriteBestOffer {
  BestOffer toHotelBestOffer() {
    return BestOffer(
      total: total,
      travelPrice: travelPrice,
      flightIncluded: flightIncluded,
      travelDate: travelDate.toHotelTravelDate(),
    );
  }
}

extension FavoriteTravelDateExtension on FavoriteTravelDate {
  TravelDate toHotelTravelDate() {
    return TravelDate(
      days: days,
      departureDate: departureDate,
      nights: nights,
      returnDate: returnDate,
    );
  }
}

extension FavoriteRatingInfoExtension on FavoriteRatingInfo {
  RatingInfo toHotelRatingInfo() {
    return RatingInfo(
      score: score,
      scoreDescription: scoreDescription,
      reviewsCount: reviewsCount,
    );
  }
}

extension FavoriteAnalyticsExtension on FavoriteAnalytics {
  Analytics toHotelAnalytics() {
    return Analytics(
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

extension FavoriteHotelMapper on FavoriteHotel {
  Hotel toHotel() {
    return Hotel(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      destination: destination,
      images: images
          .map((image) => HotelImage(large: image.large, small: image.small))
          .toList(),
      bestOffer: BestOffer(
        total: bestOffer.total,
        travelPrice: bestOffer.travelPrice,
        flightIncluded: bestOffer.flightIncluded,
        travelDate: TravelDate(
          days: bestOffer.travelDate.days,
          departureDate: bestOffer.travelDate.departureDate,
          nights: bestOffer.travelDate.nights,
          returnDate: bestOffer.travelDate.returnDate,
        ),
      ),
      ratingInfo: RatingInfo(
        score: ratingInfo.score,
        scoreDescription: ratingInfo.scoreDescription,
        reviewsCount: ratingInfo.reviewsCount,
      ),
      badges: badges,
      categoryType: categoryType,
      hotelId: hotelId,
      analytics: Analytics(
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
