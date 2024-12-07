// Unit Test file for favorites_data_source.dartimport 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/data/data_sources/favorites_data_source.dart';
import 'package:invia_case_study/features/favorites/data/models/favorite_model.dart';
import 'package:invia_case_study/features/network/api_endpoints.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockHttpClient _mockHttpClient;
  late FavoritesDataSourceImpl _favoriteDataSource;
  late MockDio _mockDioClient;

  setUp(() {
    _mockHttpClient = MockHttpClient();
    _mockDioClient = MockDio();
    when(() => _mockHttpClient.dioClient).thenReturn(_mockDioClient);

    _favoriteDataSource = FavoritesDataSourceImpl(httpClient: _mockHttpClient);
  });

  group('FavoriteDataSource', () {
    const tFavoriteHotels = [FavoriteModel.empty()];
    final tResponseData = {
      'hotels': tFavoriteHotels.map((hotel) => hotel.toMap()).toList(),
    };

    test('should be a subclass of [FavoritesDataSource]', () {
      expect(_favoriteDataSource, isA<FavoritesDataSource>());
    });

    test(
      'should return [List<HotelModel>] when the status code is 200',
      () async {
        when(
          () => _mockDioClient.get<Map<String, dynamic>>(
            any(),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(
              path: ApiEndpoints.baseURL + ApiEndpoints.hotels,
            ),
          ),
        );

        // Act
        final result = await _favoriteDataSource.getHotels();

        // Assert
        expect(result, equals(tFavoriteHotels));

        verify(
          () => _mockDioClient.get<Map<String, dynamic>>(
            ApiEndpoints.baseURL + ApiEndpoints.hotels,
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(_mockDioClient);
      },
    );

    test(
      'should throw ApiException when Dio throws a DioException',
      () async {
        when(
          () => _mockDioClient.get<Map<String, dynamic>>(
            any(),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: ApiEndpoints.baseURL + ApiEndpoints.hotels,
            ),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(
                path: ApiEndpoints.baseURL + ApiEndpoints.hotels,
              ),
            ),
          ),
        );

        // Act
        final call = _favoriteDataSource.getHotels();

        // Assert
        expect(call, throwsA(isA<ApiException>()));

        verify(
          () => _mockDioClient.get<Map<String, dynamic>>(
            ApiEndpoints.baseURL + ApiEndpoints.hotels,
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(_mockDioClient);
      },
    );
  });
}
