// ignore_for_file: one_member_abstracts

import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';

abstract class FavoritesRepository {
  const FavoritesRepository();

  ResultFuture<List<HotelEntity>> getFavorites();

  ResultSync<List<String>> getFavoriteHotelIds();
}
