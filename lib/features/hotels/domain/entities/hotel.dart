// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';

class Hotel extends Equatable {
  const Hotel({
    required this.id,
    required this.name,
    required this.category,
    required this.destination,
    required this.bestOffer,
    required this.ratingInfo,
    required this.analytics,
    required this.hotelId,
    this.images = const [],
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final int category;
  final String destination;
  final List<HotelImage> images;
  final BestOffer bestOffer;
  final RatingInfo ratingInfo;
  final Analytics analytics;
  final bool isFavorite;
  final String hotelId;

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        destination,
        images,
        bestOffer,
        ratingInfo,
        analytics,
        isFavorite,
        hotelId,
      ];

  Hotel copyWith({
    String? id,
    String? name,
    int? category,
    String? destination,
    List<HotelImage>? images,
    BestOffer? bestOffer,
    RatingInfo? ratingInfo,
    Analytics? analytics,
    bool? isFavorite,
    String? hotelId,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      destination: destination ?? this.destination,
      images: images ?? this.images,
      bestOffer: bestOffer ?? this.bestOffer,
      ratingInfo: ratingInfo ?? this.ratingInfo,
      analytics: analytics ?? this.analytics,
      isFavorite: isFavorite ?? this.isFavorite,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}

class BestOffer extends Equatable {
  const BestOffer({
    required this.total,
    required this.simplePricePerPerson,
    required this.flightIncluded,
    required this.travelDate,
    required this.roomGroups,
  });

  const BestOffer.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const TravelDate.empty(),
          roomGroups: const [],
        );

  final int total;
  final int simplePricePerPerson;
  final bool flightIncluded;
  final TravelDate travelDate;
  final List<RoomGroup> roomGroups;

  @override
  List<Object?> get props => [
        total,
        simplePricePerPerson,
        flightIncluded,
        travelDate,
        roomGroups,
      ];

  @override
  String toString() {
    return 'BestOffer{total: $total, simplePricePerPerson: $simplePricePerPerson, '
        'flightIncluded: $flightIncluded, travelDate: $travelDate, roomGroups: $roomGroups}';
  }
}

class RoomGroup extends Equatable {
  const RoomGroup({
    required this.name,
    required this.boarding,
  });

  const RoomGroup.empty()
      : this(
          name: '',
          boarding: '',
        );

  final String name;
  final String boarding;

  @override
  List<Object?> get props => [name, boarding];

  @override
  String toString() {
    return 'RoomGroup{name: $name, boarding: $boarding}';
  }
}

class TravelDate extends Equatable {
  const TravelDate({
    required this.days,
    required this.nights,
  });

  const TravelDate.empty()
      : this(
          days: 0,
          nights: 0,
        );

  final int days;
  final int nights;

  @override
  List<Object?> get props => [
        days,
        nights,
      ];

  @override
  String toString() {
    return 'TravelDate{days: $days, nights: $nights}';
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

class Analytics extends Equatable {
  const Analytics({
    required this.currency,
    required this.itemCategory,
    required this.itemId,
    required this.itemListName,
    required this.itemName,
    required this.itemRooms,
    required this.price,
  });

  const Analytics.empty()
      : this(
          currency: '',
          itemCategory: '',
          itemId: '',
          itemListName: '',
          itemName: '',
          itemRooms: '',
          price: '',
        );

  final String currency;
  final String itemCategory;
  final String itemId;
  final String itemListName;
  final String itemName;
  final String itemRooms;
  final String price;

  @override
  List<Object?> get props => [
        currency,
        itemCategory,
        itemId,
        itemListName,
        itemName,
        itemRooms,
        price,
      ];

  @override
  String toString() {
    return 'Analytics{currency: $currency, itemCategory: $itemCategory, itemId: $itemId, '
        'itemListName: $itemListName, itemName: $itemName, itemRooms: $itemRooms, price: $price}';
  }
}

extension HotelMapper on Hotel {
  FavoriteHotel toFavoriteHotel() {
    return FavoriteHotel(
      id: id,
      name: name,
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
        simplePricePerPerson: bestOffer.simplePricePerPerson,
        flightIncluded: bestOffer.flightIncluded,
        travelDate: TravelDateHive(
          days: bestOffer.travelDate.days,
          nights: bestOffer.travelDate.nights,
        ),
        roomGroups: bestOffer.roomGroups
            .map(
              (group) => RoomGroupHive(
                name: group.name,
                boarding: group.boarding,
              ),
            )
            .toList(),
      ),
      ratingInfo: RatingInfoHive(
        score: ratingInfo.score,
        scoreDescription: ratingInfo.scoreDescription,
        reviewsCount: ratingInfo.reviewsCount,
      ),
      hotelId: hotelId,
      analytics: AnalyticsHive(
        currency: analytics.currency,
        itemCategory: analytics.itemCategory,
        itemId: analytics.itemId,
        itemListName: analytics.itemListName,
        itemName: analytics.itemName,
        itemRooms: analytics.itemRooms,
        price: analytics.price,
      ),
      isFavorite: true,
    );
  }
}
