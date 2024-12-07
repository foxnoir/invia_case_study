import 'package:invia_case_study/features/storage/local_database.dart';

class InMemoryLocalDatabase implements LocalDatabase {
  final List<String> _favoriteHotelIds = [];

  @override
  List<String> getAllFavoriteHotelIds() {
    return List.unmodifiable(_favoriteHotelIds);
  }

  @override
  Future<void> addFavoriteHotelId({required String hotelId}) async {
    if (!_favoriteHotelIds.contains(hotelId)) {
      _favoriteHotelIds.add(hotelId);
    }
  }

  @override
  Future<void> removeFavoriteHotelId({required String id}) async {
    _favoriteHotelIds.remove(id);
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<void> flush() {
    // TODO: implement flush
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
