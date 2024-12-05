// ignore_for_file: one_member_abstracts

import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

abstract class HotelsRepository {
  const HotelsRepository();

  ResultFuture<List<Hotel>> getHotels();

  ResultFuture<void> addFavoriteHotel({required Hotel hotel});
}
