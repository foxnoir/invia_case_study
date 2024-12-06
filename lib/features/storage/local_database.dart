import 'dart:async';

import 'package:invia_case_study/features/storage/local_database_impl.dart';

abstract class LocalDatabase {
  static final localDatabase = LocalDatabaseImpl();

  Future<void> init();

  Future<void> clear();

  Future<void> flush();

  List<String> getAllFavoriteHotelIds();

  Future<void> removeFavoriteHotelId({required String id});

  Future<void> addFavoriteHotelId({required String hotelId});
}
