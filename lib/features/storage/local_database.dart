import 'dart:async';

import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';
import 'package:invia_case_study/features/storage/local_database_impl.dart';

abstract class LocalDatabase {
  static final localDatabase = LocalDatabaseImpl();

  Future<void> init();

  Future<void> clear();

  Future<void> flush();

  List<FavoriteHotel> getallFavoriteHotels();

  List<String> getAllFavoriteHotelIds();

  Future<void> removeFavoriteHotelById({required String id});

  Future<void> addFavoriteHotel({
    required FavoriteHotel favoriteHotel,
  });
}
