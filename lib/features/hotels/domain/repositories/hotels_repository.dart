// ignore_for_file: one_member_abstracts

import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

abstract class HotelsRepository {
  const HotelsRepository();

  ResultFuture<List<Hotel>> ge_tHotels();

  ResultFuture<void> addFavoriteHotel({required Hotel hotel});

  ResultFuture<void> removeFavoriteHotelId({required String id});

  ResultSync<List<String>> getFavoriteHotelIds();
}
