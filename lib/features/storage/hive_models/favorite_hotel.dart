import 'package:hive/hive.dart';

part 'favorite_hotel.g.dart';

@HiveType(typeId: 0)
class FavoriteHotel {
  FavoriteHotel({required this.id});

  @HiveField(0)
  final String id;
}
