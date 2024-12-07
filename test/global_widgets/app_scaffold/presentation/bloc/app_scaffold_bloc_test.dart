import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelsRepository extends Mock implements HotelsRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late AppScaffoldBloc appScaffoldBloc;
  late MockHotelsRepository mockHotelsRepository;
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() {
    mockHotelsRepository = MockHotelsRepository();
    mockFavoritesRepository = MockFavoritesRepository();
    appScaffoldBloc = AppScaffoldBloc(
      hotelsRepository: mockHotelsRepository,
      favoritesRepository: mockFavoritesRepository,
    );
  });

  tearDown(() async {
    await appScaffoldBloc.close();
  });

  final testHotel = const Hotel.empty().copyWith(
    id: '1',
    name: 'Test Hotel',
    hotelId: 'hotel123',
    isFavorite: false,
  );

  final updatedTestHotel = testHotel.copyWith(isFavorite: true);
  final favoritesList = [testHotel];

  group('AppScaffoldBloc', () {
    group('AddFavoriteEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldUpdated] when AddFavoriteEvent is successful',
        build: () {
          when(() => mockHotelsRepository.addFavoriteHotel(hotel: testHotel))
              .thenAnswer((_) async => const Right(null));

          when(() => mockFavoritesRepository.getFavorites())
              .thenAnswer((_) async => Right(favoritesList));

          return appScaffoldBloc;
        },
        act: (bloc) => bloc.add(AddFavoriteEvent(testHotel)),
        expect: () => [
          AppScaffoldUpdated(hotel: updatedTestHotel, favorites: favoritesList),
        ],
      );
    });

    group('RemoveFavoriteEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldUpdated] when RemoveFavoriteEvent is successful',
        build: () {
          when(
            () => mockHotelsRepository.removeFavoriteHotelId(
              id: testHotel.hotelId,
            ),
          ).thenAnswer((_) async => const Right(null));

          when(() => mockFavoritesRepository.getFavorites())
              .thenAnswer((_) async => Right(favoritesList));

          return appScaffoldBloc;
        },
        act: (bloc) => bloc.add(RemoveFavoriteEvent(testHotel)),
        expect: () => [
          AppScaffoldUpdated(
            hotel: testHotel.copyWith(isFavorite: false),
            favorites: favoritesList,
          ),
        ],
      );
    });

    group('ResetErrorEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldInitial] when ResetErrorEvent is added',
        build: () => appScaffoldBloc,
        act: (bloc) => bloc.add(ResetErrorEvent()),
        expect: () => [
          const AppScaffoldInitial(),
        ],
      );
    });
  });
}
