import 'package:equatable/equatable.dart';

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
    this.images = const [],
  });

  const Hotel.empty()
      : this(
          id: '',
          name: '',
          latitude: 0,
          longitude: 0,
          category: 0,
          destination: '',
          images: const [],
          bestOffer: const BestOffer.empty(),
          ratingInfo: const RatingInfo.empty(),
        );

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int category;
  final String destination;
  final List<HotelImage> images;
  final BestOffer bestOffer;
  final RatingInfo ratingInfo;

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        category,
        destination,
        images.length,
        bestOffer,
        ratingInfo,
      ];

  @override
  String toString() {
    return 'Hotel{id: $id, name: $name, destination: $destination, '
        'latitude: $latitude, longitude: $longitude, category: $category}';
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
