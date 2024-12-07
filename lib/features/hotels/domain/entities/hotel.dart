import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  const Hotel({
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

  final String id;
  final String name;
  final int category;
  final String destination;
  final List<HotelImage> images;
  final BestOffer bestOffer;
  final RatingInfo ratingInfo;
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

  Hotel copyWith({
    String? id,
    String? name,
    int? category,
    String? destination,
    List<HotelImage>? images,
    BestOffer? bestOffer,
    RatingInfo? ratingInfo,
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
    required this.overallRoomDetails,
  });

  const BestOffer.empty()
      : this(
          total: 0,
          simplePricePerPerson: 0,
          flightIncluded: false,
          travelDate: const TravelDate.empty(),
          roomGroups: const [],
          overallRoomDetails: const RoomDetails.empty(),
        );

  final int total;
  final int simplePricePerPerson;
  final bool flightIncluded;
  final TravelDate travelDate;
  final List<RoomGroup> roomGroups;
  final RoomDetails overallRoomDetails;

  @override
  List<Object?> get props => [
        total,
        simplePricePerPerson,
        flightIncluded,
        travelDate,
        roomGroups,
        overallRoomDetails,
      ];

  @override
  String toString() {
    return 'BestOffer{total: $total, '
        'simplePricePerPerson: $simplePricePerPerson, '
        'flightIncluded: $flightIncluded, travelDate: $travelDate, '
        'roomGroups: $roomGroups, overallRoomDetails: $overallRoomDetails}';
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

class RoomDetails extends Equatable {
  const RoomDetails({
    required this.name,
    required this.boarding,
    required this.adultCount,
    required this.childrenCount,
  });

  const RoomDetails.empty()
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

  @override
  String toString() {
    return 'RoomDetails{name: $name, boarding: $boarding, '
        'adultCount: $adultCount, childrenCount: $childrenCount}';
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
