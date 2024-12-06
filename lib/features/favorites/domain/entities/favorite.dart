import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class Favorite extends Equatable {
  const Favorite({
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
  final List<FavoriteImage> images;
  final FavoriteBestOffer bestOffer;
  final FavoriteRatingInfo ratingInfo;
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
    required this.simplePricePerPerson,
    required this.flightIncluded,
    required this.travelDate,
    required this.roomGroups,
    required this.overallRoomDetails,
  });

  const FavoriteBestOffer.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const FavoriteTravelDate.empty(),
          roomGroups: const [],
          overallRoomDetails: const FavoriteRoomDetails.empty(),
        );

  final int total;
  final int simplePricePerPerson;
  final bool flightIncluded;
  final FavoriteTravelDate travelDate;
  final List<FavoriteRoomGroup> roomGroups;
  final FavoriteRoomDetails overallRoomDetails;

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

class FavoriteRoomGroup extends Equatable {
  const FavoriteRoomGroup({
    required this.name,
    required this.boarding,
  });

  const FavoriteRoomGroup.empty()
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

class FavoriteRoomDetails extends Equatable {
  const FavoriteRoomDetails({
    required this.name,
    required this.boarding,
    required this.adultCount,
    required this.childrenCount,
  });

  const FavoriteRoomDetails.empty()
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

class FavoriteTravelDate extends Equatable {
  const FavoriteTravelDate({
    required this.days,
    required this.nights,
  });

  const FavoriteTravelDate.empty()
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
      isFavorite: isFavorite,
      id: id,
      name: name,
      category: category,
      destination: destination,
      images: images
          .map((img) => HotelImage(large: img.large, small: img.small))
          .toList(),
      bestOffer: bestOffer.toHotelBestOffer(),
      ratingInfo: ratingInfo.toHotelRatingInfo(),
      hotelId: favoriteId,
    );
  }
}

extension FavoriteBestOfferExtension on FavoriteBestOffer {
  BestOffer toHotelBestOffer() {
    return BestOffer(
      total: total,
      simplePricePerPerson: simplePricePerPerson,
      flightIncluded: flightIncluded,
      travelDate: travelDate.toHotelTravelDate(),
      roomGroups: roomGroups.map((group) => group.toHotelRoomGroup()).toList(),
      overallRoomDetails: overallRoomDetails.toHotelRoomDetails(),
    );
  }
}

extension FavoriteRoomGroupExtension on FavoriteRoomGroup {
  RoomGroup toHotelRoomGroup() {
    return RoomGroup(
      name: name,
      boarding: boarding,
    );
  }
}

extension FavoriteRoomDetailsExtension on FavoriteRoomDetails {
  RoomDetails toHotelRoomDetails() {
    return RoomDetails(
      name: name,
      boarding: boarding,
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}

extension FavoriteTravelDateExtension on FavoriteTravelDate {
  TravelDate toHotelTravelDate() {
    return TravelDate(
      days: days,
      nights: nights,
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
