// ignore_for_file: one_member_abstracts

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';

abstract class HotelsDataSource {
  Future<List<HotelModel>> getHotels();
}

class HotelsDataSourceImpl implements HotelsDataSource {
  final http.Client _client = DI.getIt<http.Client>();

  @override
  Future<List<HotelModel>> getHotels() async {
    final response = await _client.get(
      Uri.https('dkndmolrswy7b.cloudfront.net', '/hotels.json'),
    );

    if (response.statusCode != 200) {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }

    try {
      final decodedJson = jsonDecode(response.body) as DataMap;
      final hotelsList = decodedJson['hotels']! as List<dynamic>;
      return hotelsList
          .map((json) => HotelModel.fromMap(json as DataMap))
          .toList();
    } catch (e) {
      logger.i('fetching hotels failed');
      throw ApiException(message: 'Error parsing hotels: $e', statusCode: 500);
    }
  }
}
