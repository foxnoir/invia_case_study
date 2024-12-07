// ignore_for_file: one_member_abstracts

import 'package:dio/dio.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/utils/type_defs.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/network/api_endpoints.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/http_client.dart';

abstract class HotelsDataSource {
  Future<List<HotelModel>> getHotels();
}

class HotelsDataSourceImpl implements HotelsDataSource {
  HotelsDataSourceImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? DI.getIt<HttpClient>();
  final HttpClient _httpClient;

  @override
  Future<List<HotelModel>> getHotels() async {
    try {
      final response = await _httpClient.dioClient.get<Map<String, dynamic>>(
        ApiEndpoints.baseURL + ApiEndpoints.hotels,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      final decodedJson = response.data! as DataMap;
      final hotelsList = decodedJson['hotels']! as List<dynamic>;

      return hotelsList
          .map((json) => HotelModel.fromMap(json as DataMap))
          .toList();
    } on NoConnectivityException {
      throw const ApiException(
        message: 'No internet connection.',
        statusCode: 0,
      );
    } on DioException catch (e) {
      logger.e('API request failed', e, null);
      throw ApiException(
        message: e.response?.statusMessage ?? 'An unexpected error occurred.',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
