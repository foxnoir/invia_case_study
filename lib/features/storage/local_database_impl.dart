import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/features/storage/hive_models/favorite_hotel.dart';
import 'package:invia_case_study/features/storage/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseImpl implements LocalDatabase {
  bool _isInitialized = false;
  late Box<FavoriteHotel> _favoriteHotelBox;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String DB_ENCRYPTION_KEY = 'DB_ENCRYPTION_KEY';
  final String FIRST_RUN_KEY = 'FIRST_RUN_KEY';
  final String APP_CONFIG_KEY = 'APP_CONFIG_KEY';
  final String DB_VERSION_KEY = 'DB_VERSION_KEY';
  final int DB_VERSION_VALUE = 1;

  @override
  Future<void> init() async {
    if (_isInitialized == true) {
      return;
    }
    final sharedPreferences = await SharedPreferences.getInstance();
    await _clearSecureStorageForFirstRun(sharedPreferences);
    try {
      _registerAdapter();
      await Hive.initFlutter();
      await _openBoxes();
    } catch (exception) {
      logger.i(exception.toString());
    }
    _isInitialized = true;
  }

  void _registerAdapter() {
    Hive
      ..registerAdapter<FavoriteHotel>(FavoriteHotelAdapter())
      ..registerAdapter<FavoriteHotelImageHive>(FavoriteHotelImageHiveAdapter())
      ..registerAdapter<BestOfferHive>(BestOfferHiveAdapter())
      ..registerAdapter<TravelDateHive>(TravelDateHiveAdapter())
      ..registerAdapter<RatingInfoHive>(RatingInfoHiveAdapter())
      ..registerAdapter<AnalyticsHive>(AnalyticsHiveAdapter());
  }

  Future<void> _openBoxes() async {
    final hiveAesCipher = await _getEncryptionCipher();
    _favoriteHotelBox = await Hive.openBox<FavoriteHotel>(
      'favoriteHotelBox',
      encryptionCipher: hiveAesCipher,
    );
    logger.i('Box opened with ${_favoriteHotelBox.length} entries.');
  }

  Future<void> _clearSecureStorageForFirstRun(
    SharedPreferences sharedPreferences,
  ) async {
    if (sharedPreferences.getBool(FIRST_RUN_KEY) ?? true) {
      logger.i('**** cleaning secure storage *****');
      await _secureStorage.deleteAll();
      await sharedPreferences.setBool(FIRST_RUN_KEY, false);
    }
  }

  Future<HiveAesCipher> _getEncryptionCipher() async {
    final generatedEncryptionKey =
        await _secureStorage.read(key: DB_ENCRYPTION_KEY);
    if (generatedEncryptionKey == null) {
      final encryptionKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: DB_ENCRYPTION_KEY,
        value: base64UrlEncode(encryptionKey),
      );
    }
    final encodedKey = await _secureStorage.read(key: DB_ENCRYPTION_KEY) ?? '';
    final encryptionKey = base64Url.decode(encodedKey);
    return HiveAesCipher(encryptionKey);
  }

  @override
  Future<void> clear() async {
    await _favoriteHotelBox.clear();
    await Hive.deleteFromDisk();
    await _secureStorage.deleteAll();
    _isInitialized = false;
    await init();
  }

  @override
  Future<void> flush() async {
    await _favoriteHotelBox.flush();
  }

  @override
  Future<void> deleteFavoriteHotelById({required String id}) async {
    try {
      final hotelKey = _favoriteHotelBox.keys.firstWhere(
        (key) => _favoriteHotelBox.get(key)?.id == id,
        orElse: () => null,
      );

      if (hotelKey != null) {
        await _favoriteHotelBox.delete(hotelKey);
        logger.i('Favorite hotel with id $id deleted successfully.');
      } else {
        logger.i('No favorite hotel found with id $id.');
      }
    } catch (e) {
      logger.e('Error deleting favorite hotel with id $id', e, null);
      rethrow;
    }
  }

  @override
  List<FavoriteHotel> getllFavoriteHotels() {
    return _favoriteHotelBox.values.toList();
  }

  @override
  Future<void> addFavoriteHotel({
    required FavoriteHotel favoriteHotel,
  }) async {
    try {
      await _favoriteHotelBox.put(favoriteHotel.id, favoriteHotel);
    } catch (e) {
      logger.e('Error while saving favoriteHotel', e, null);
    }
  }
}
