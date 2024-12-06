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
  final int DB_VERSION_VALUE = 1;

  @override
  Future<void> init() async {
    if (_isInitialized) return;

    final sharedPreferences = await SharedPreferences.getInstance();
    await _clearSecureStorageForFirstRun(sharedPreferences);

    try {
      _registerAdapter();
      await Hive.initFlutter();
      await _openBoxes();
    } catch (e) {
      logger.e('Error initializing database', e, null);
    }
    _isInitialized = true;
  }

  void _registerAdapter() {
    Hive.registerAdapter<FavoriteHotel>(FavoriteHotelAdapter());
  }

  Future<void> _openBoxes() async {
    final hiveAesCipher = await _getEncryptionCipher();
    _favoriteHotelBox = await Hive.openBox<FavoriteHotel>(
      'favoriteHotelBox',
      encryptionCipher: hiveAesCipher,
    );
    logger
        .i('FavoriteHotelBox opened with ${_favoriteHotelBox.length} entries.');
  }

  Future<void> _clearSecureStorageForFirstRun(
    SharedPreferences sharedPreferences,
  ) async {
    if (sharedPreferences.getBool(FIRST_RUN_KEY) ?? true) {
      logger.i('Clearing secure storage for first run.');
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
  Future<void> addFavoriteHotelId({required String hotelId}) async {
    try {
      await _favoriteHotelBox.put(hotelId, FavoriteHotel(id: hotelId));
      logger.i('Added favorite hotel with id: $hotelId');
    } catch (e) {
      logger.e('Error adding favorite hotel ID', e, null);
    }
  }

  @override
  Future<void> removeFavoriteHotelId({required String id}) async {
    try {
      await _favoriteHotelBox.delete(id);
      logger.i('Removed favorite hotel with id: $id');
    } catch (e) {
      logger.e('Error removing favorite hotel ID', e, null);
    }
  }

  @override
  List<String> getAllFavoriteHotelIds() {
    return _favoriteHotelBox.values.map((hotel) => hotel.id).toList();
  }

  @override
  Future<void> clear() async {
    await _favoriteHotelBox.clear();
    await Hive.deleteFromDisk();
    await _secureStorage.deleteAll();
    _isInitialized = false;
    logger.i('Database cleared and reset.');
    await init();
  }

  @override
  Future<void> flush() async {
    await _favoriteHotelBox.flush();
  }
}
