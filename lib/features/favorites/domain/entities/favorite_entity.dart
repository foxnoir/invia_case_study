import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';

class FavoriteEntity extends Equatable {
  const FavoriteEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.destination,
    required this.bestOffer,
    required this.ratingInfo,
    required this.favoriteId,
    this.images = const [],
    this.isFavorite = true,
  });

  final String id;
  final String name;
  final int category;
  final String destination;
  final List<FavoriteImageEnity> images;
  final FavoriteBestOfferEntity bestOffer;
  final FavoriteRatingInfoEntity ratingInfo;
  final String favoriteId;
  final bool isFavorite;

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        destination,
        images,
        bestOffer,
        ratingInfo,
        favoriteId,
        isFavorite,
      ];
}

class FavoriteImageEnity extends Equatable {
  const FavoriteImageEnity({
    required this.large,
    required this.small,
  });

  const FavoriteImageEnity.empty()
      : this(
          large: '',
          small: '',
        );

  final String large;
  final String small;

  @override
  List<Object?> get props => [large, small];
}

class FavoriteBestOfferEntity extends Equatable {
  const FavoriteBestOfferEntity({
    required this.total,
    required this.simplePricePerPerson,
    required this.flightIncluded,
    required this.travelDate,
    required this.roomGroups,
    required this.overallRoomDetails,
  });

  const FavoriteBestOfferEntity.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const FavoriteTravelDateEntity.empty(),
          roomGroups: const [],
          overallRoomDetails: const FavoriteRoomDetailsEntity.empty(),
        );

  final int total;
  final int simplePricePerPerson;
  final bool flightIncluded;
  final FavoriteTravelDateEntity travelDate;
  final List<FavoriteRoomGroupEntity> roomGroups;
  final FavoriteRoomDetailsEntity overallRoomDetails;

  @override
  List<Object?> get props => [
        total,
        simplePricePerPerson,
        flightIncluded,
        travelDate,
        roomGroups,
        overallRoomDetails,
      ];
}

class FavoriteRoomGroupEntity extends Equatable {
  const FavoriteRoomGroupEntity({
    required this.name,
    required this.boarding,
  });

  const FavoriteRoomGroupEntity.empty()
      : this(
          name: '',
          boarding: '',
        );

  final String name;
  final String boarding;

  @override
  List<Object?> get props => [
        name,
        boarding,
      ];
}

class FavoriteRoomDetailsEntity extends Equatable {
  const FavoriteRoomDetailsEntity({
    required this.name,
    required this.boarding,
    required this.adultCount,
    required this.childrenCount,
  });

  const FavoriteRoomDetailsEntity.empty()
      : this(
          name: '',
          boarding: '',
          adultCount: 0,
          childrenCount: 0,
        );

  final String name;
  final String boarding;
  final int adultCount;
  final int childrenCount;

  @override
  List<Object?> get props => [
        name,
        boarding,
        adultCount,
        childrenCount,
      ];
}

class FavoriteTravelDateEntity extends Equatable {
  const FavoriteTravelDateEntity({
    required this.days,
    required this.nights,
  });

  const FavoriteTravelDateEntity.empty()
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
}

class FavoriteRatingInfoEntity extends Equatable {
  const FavoriteRatingInfoEntity({
    required this.score,
    required this.scoreDescription,
    required this.reviewsCount,
  });

  const FavoriteRatingInfoEntity.empty()
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

extension FavoriteExtension on FavoriteEntity {
  HotelEntity toHotel() {
    return HotelEntity(
      isFavorite: isFavorite,
      id: id,
      name: name,
      category: category,
      destination: destination,
      images: images
          .map((img) => HotelImageEntity(large: img.large, small: img.small))
          .toList(),
      bestOffer: bestOffer.toHotelBestOffer(),
      ratingInfo: ratingInfo.toHotelRatingInfo(),
      hotelId: favoriteId,
    );
  }
}

extension FavoriteBestOfferEntityExtension on FavoriteBestOfferEntity {
  BestOfferEntity toHotelBestOffer() {
    return BestOfferEntity(
      total: total,
      simplePricePerPerson: simplePricePerPerson,
      flightIncluded: flightIncluded,
      travelDate: travelDate.toHotelTravelDate(),
      roomGroups: roomGroups.map((group) => group.toHotelRoomGroup()).toList(),
      overallRoomDetails: overallRoomDetails.toHotelRoomDetails(),
    );
  }
}

extension FavoriteRoomGroupEntityExtension on FavoriteRoomGroupEntity {
  RoomGroupEntity toHotelRoomGroup() {
    return RoomGroupEntity(
      name: name,
      boarding: boarding,
    );
  }
}

extension FavoriteRoomDetailsEntityExtension on FavoriteRoomDetailsEntity {
  RoomDetailsEntity toHotelRoomDetails() {
    return RoomDetailsEntity(
      name: name,
      boarding: boarding,
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}

extension FavoriteTravelDateEntityExtension on FavoriteTravelDateEntity {
  TravelDateEntity toHotelTravelDate() {
    return TravelDateEntity(
      days: days,
      nights: nights,
    );
  }
}

extension FavoriteRatingInfoEntityExtension on FavoriteRatingInfoEntity {
  RatingInfoEntity toHotelRatingInfo() {
    return RatingInfoEntity(
      score: score,
      scoreDescription: scoreDescription,
      reviewsCount: reviewsCount,
    );
  }
}
