// ignore_for_file: one_member_abstracts

import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';

abstract class HotelsRepository {
  const HotelsRepository();

  ResultFuture<List<HotelEntity>> ge_tHotels();

  ResultFuture<void> addFavoriteHotel({required HotelEntity hotel});

  ResultFuture<void> removeFavoriteHotelId({required String id});

  ResultSync<List<String>> getFavoriteHotelIds();
}
