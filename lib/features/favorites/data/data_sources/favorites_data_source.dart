// ignore_for_file: one_member_abstracts

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/favorites/data/models/favorite_model.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';

abstract class FavoritesDataSource {
  Future<List<FavoriteModel>> getFavorites();
}

class FavoritesDataSourceImpl implements FavoritesDataSource {
  final http.Client _client = DI.getIt<http.Client>();

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final response = await _client.get(
      Uri.https('dkndmolrswy7b.cloudfront.net', '/favorites.json'),
    );

    if (response.statusCode != 200) {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }

    try {
      final decodedJson = jsonDecode(response.body) as DataMap;
      final favoritesList = decodedJson['favorites']! as List<dynamic>;
      return favoritesList
          .map((json) => FavoriteModel.fromMap(json as DataMap))
          .toList();
    } catch (e) {
      logger.i('fetching favorites failed');
      throw ApiException(
        message: 'Error parsing favorites: $e',
        statusCode: 500,
      );
    }
  }
}
