// ignore_for_file: one_member_abstracts

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/network/api_endpoints.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';

abstract class HotelDataSource {
  Future<List<HotelModel>> getHotels();
}

class HotelDataSourceImpl implements HotelDataSource {
  HotelDataSourceImpl();

  final http.Client _client = DI.getIt<http.Client>();

  @override
  Future<List<HotelModel>> getHotels() async {
    try {
      final response = await _client
          .get(Uri.https(ApiEndpoints.baseURL, ApiEndpoints.hotels));

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(HotelModel.fromMap)
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
