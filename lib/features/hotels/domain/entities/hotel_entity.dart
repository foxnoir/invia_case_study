import 'package:equatable/equatable.dart';

class HotelEntity extends Equatable {
  const HotelEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.destination,
    required this.bestOffer,
    required this.ratingInfo,
    required this.hotelId,
    this.images = const [],
    this.isFavorite = false,
  });
  const HotelEntity.empty()
      : this(
          id: '',
          name: '',
          category: 0,
          destination: '',
          bestOffer: const BestOfferEntity.empty(),
          ratingInfo: const RatingInfoEntity.empty(),
          hotelId: '',
          images: const [],
          isFavorite: false,
        );

  final String id;
  final String name;
  final int category;
  final String destination;
  final List<HotelImageEntity> images;
  final BestOfferEntity bestOffer;
  final RatingInfoEntity ratingInfo;
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
        isFavorite,
        hotelId,
      ];

  HotelEntity copyWith({
    String? id,
    String? name,
    int? category,
    String? destination,
    List<HotelImageEntity>? images,
    BestOfferEntity? bestOffer,
    RatingInfoEntity? ratingInfo,
    bool? isFavorite,
    String? hotelId,
  }) {
    return HotelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      destination: destination ?? this.destination,
      images: images ?? this.images,
      bestOffer: bestOffer ?? this.bestOffer,
      ratingInfo: ratingInfo ?? this.ratingInfo,
      isFavorite: isFavorite ?? this.isFavorite,
      hotelId: hotelId ?? this.hotelId,
    );
  }
}

class BestOfferEntity extends Equatable {
  const BestOfferEntity({
    required this.total,
    required this.simplePricePerPerson,
    required this.flightIncluded,
    required this.travelDate,
    required this.roomGroups,
    required this.overallRoomDetails,
  });

  const BestOfferEntity.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const TravelDateEntity.empty(),
          roomGroups: const [],
          overallRoomDetails: const RoomDetailsEntity.empty(),
        );

  final int total;
  final int simplePricePerPerson;
  final bool flightIncluded;
  final TravelDateEntity travelDate;
  final List<RoomGroupEntity> roomGroups;
  final RoomDetailsEntity overallRoomDetails;

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

class RoomGroupEntity extends Equatable {
  const RoomGroupEntity({
    required this.name,
    required this.boarding,
  });

  const RoomGroupEntity.empty()
      : this(
          name: '',
          boarding: '',
        );

  final String name;
  final String boarding;

  @override
  List<Object?> get props => [name, boarding];
}

class RoomDetailsEntity extends Equatable {
  const RoomDetailsEntity({
    required this.name,
    required this.boarding,
    required this.adultCount,
    required this.childrenCount,
  });

  const RoomDetailsEntity.empty()
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

class TravelDateEntity extends Equatable {
  const TravelDateEntity({
    required this.days,
    required this.nights,
  });

  const TravelDateEntity.empty()
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

class HotelImageEntity extends Equatable {
  const HotelImageEntity({
    required this.large,
    required this.small,
  });

  const HotelImageEntity.empty()
      : this(
          large: '',
          small: '',
        );

  final String large;
  final String small;

  @override
  List<Object?> get props => [large, small];
}

class RatingInfoEntity extends Equatable {
  const RatingInfoEntity({
    required this.score,
    required this.scoreDescription,
    required this.reviewsCount,
  });

  const RatingInfoEntity.empty()
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
