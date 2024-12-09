import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/data/data_sources/hotels_data_source.dart';
import 'package:invia_case_study/features/hotels/data/models/hotel_model.dart';
import 'package:invia_case_study/features/network/api_endpoints.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';
import 'package:invia_case_study/features/network/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockHttpClient _mockHttpClient;
  late HotelsDataSourceImpl _hotelDataSource;
  late MockDio _mockDioClient;

  setUp(() {
    _mockHttpClient = MockHttpClient();
    _mockDioClient = MockDio();
    when(() => _mockHttpClient.dioClient).thenReturn(_mockDioClient);

    _hotelDataSource = HotelsDataSourceImpl(httpClient: _mockHttpClient);
  });

  group('HotalDataSource', () {
    const _tHotels = [HotelModel.empty()];
    final tResponseData = {
      'hotels': _tHotels.map((hotel) => hotel.toMap()).toList(),
    };

    test('should be a subclass of [HotelsDataSource]', () {
      expect(_hotelDataSource, isA<HotelsDataSource>());
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

        final result = await _hotelDataSource.getHotels();

        expect(result, equals(_tHotels));

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

        final call = _hotelDataSource.getHotels;

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
