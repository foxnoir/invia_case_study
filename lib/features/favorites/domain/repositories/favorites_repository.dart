// ignore_for_file: one_member_abstracts

import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesRepository {
  const FavoritesRepository();

  ResultFuture<List<Favorite>> getFavorites();
}
