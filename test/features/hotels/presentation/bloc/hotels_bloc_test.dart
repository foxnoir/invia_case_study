import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/test_di.config.dart';
import '../../../../di/test_di.dart';

class MockHotelsRepository extends Mock implements HotelsRepository {}

void main() {
  late MockHotelsRepository _mockHotelsRepository;
  late HotelsBloc _hotelsBloc;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await TestDI.getIt.reset();
    TestDI.getIt.initTest();
  });

  setUp(() async {
    await TestDI.getIt.reset();
    TestDI.getIt.initTest();

    _mockHotelsRepository = TestDI.getIt<MockHotelsRepository>();
    _hotelsBloc = HotelsBloc(hotelsRepository: _mockHotelsRepository);
  });

  tearDown(() async {
    await _hotelsBloc.close();
    await TestDI.getIt.reset();
  });

  group('HotelsBloc', () {
    final _tHotel1 = const Hotel.empty().copyWith(
      destination: 'City A, Country A',
    );

    final _tHotel2 = const Hotel.empty().copyWith(
      destination: 'City B, Country B',
    );

    final hotelsList = [_tHotel1, _tHotel2];

    test('initial state is HotelsInitial', () {
      expect(_hotelsBloc.state, const HotelsInitial());
    });

    blocTest<HotelsBloc, HotelsState>(
      'emits [HotelsLoading, HotelsLoaded] when '
      'FetchHotelsEvent is added and repository succeeds',
      build: () {
        when(() => _mockHotelsRepository.ge_tHotels())
            .thenAnswer((_) async => Right(hotelsList));
        return _hotelsBloc;
      },
      act: (bloc) => bloc.add(const FetchHotelsEvent()),
      expect: () => [
        const HotelsLoading(),
        HotelsLoaded(
          hotels: hotelsList,
          location: 'Country A',
        ),
      ],
      verify: (_) {
        verify(() => _mockHotelsRepository.ge_tHotels()).called(1);
      },
    );

    blocTest<HotelsBloc, HotelsState>(
      'emits [HotelsLoading, HotelsError] '
      'when FetchHotelsEvent is added and repository fails',
      build: () {
        when(() => _mockHotelsRepository.ge_tHotels()).thenAnswer(
          (_) async =>
              const Left(ApiFailure(message: 'Error', statusCode: 500)),
        );
        return _hotelsBloc;
      },
      act: (bloc) => bloc.add(const FetchHotelsEvent()),
      expect: () => [
        const HotelsLoading(),
        const HotelsError(
          failure: ApiFailure(message: 'Error', statusCode: 500),
        ),
      ],
      verify: (_) {
        verify(() => _mockHotelsRepository.ge_tHotels()).called(1);
      },
    );
  });
}
