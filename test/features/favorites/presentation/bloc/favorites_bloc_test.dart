import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/test_di.config.dart';
import '../../../../di/test_di.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository _mockFavoritesRepository;
  late FavoritesBloc _favoritesBloc;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    await TestDI.getIt.reset();
    TestDI.getIt.initTest();

    _mockFavoritesRepository = TestDI.getIt<MockFavoritesRepository>();
    _favoritesBloc =
        FavoritesBloc(favoritesRepository: _mockFavoritesRepository);
  });

  tearDown(() async {
    await _favoritesBloc.close();
    await TestDI.getIt.reset();
  });

  group('FavoritesBloc', () {
    const tHotel1 = Hotel.empty();
    const tHtel2 = Hotel.empty();

    final hotelsList = [tHotel1, tHtel2];

    test('initial state is FavoritesInitial', () {
      expect(_favoritesBloc.state, const FavoritesInitial());
    });

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [FavoritesLoading, FavoritesLoaded] '
      'when FetchFavoritesEvent is added and repository succeeds',
      build: () {
        when(() => _mockFavoritesRepository.getFavorites())
            .thenAnswer((_) async => Right(hotelsList));
        return _favoritesBloc;
      },
      act: (bloc) => bloc.add(const FetchFavoritesEvent()),
      expect: () => [
        const FavoritesLoading(),
        FavoritesLoaded(favorites: hotelsList),
      ],
      verify: (_) {
        verify(() => _mockFavoritesRepository.getFavorites()).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [FavoritesLoading, FavoritesError] when '
      'FetchFavoritesEvent is added and repository fails',
      build: () {
        when(() => _mockFavoritesRepository.getFavorites()).thenAnswer(
          (_) async =>
              const Left(ApiFailure(message: 'Error', statusCode: 500)),
        );
        return _favoritesBloc;
      },
      act: (bloc) => bloc.add(const FetchFavoritesEvent()),
      expect: () => [
        const FavoritesLoading(),
        const FavoritesError(
          failure: ApiFailure(message: 'Error', statusCode: 500),
        ),
      ],
      verify: (_) {
        verify(() => _mockFavoritesRepository.getFavorites()).called(1);
      },
    );
  });
}
