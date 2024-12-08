import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../features/favorites/presentation/bloc/favorites_bloc_test.dart';
import '../../../../features/hotels/presentation/bloc/hotels_bloc_test.dart';

void main() {
  late AppScaffoldBloc _appScaffoldBloc;
  late MockHotelsRepository _mockHotelsRepository;
  late MockFavoritesRepository _mockFavoritesRepository;

  setUp(() {
    _mockHotelsRepository = MockHotelsRepository();
    _mockFavoritesRepository = MockFavoritesRepository();
    _appScaffoldBloc = AppScaffoldBloc(
      hotelsRepository: _mockHotelsRepository,
      favoritesRepository: _mockFavoritesRepository,
    );
  });

  tearDown(() async {
    await _appScaffoldBloc.close();
  });

  final tes_tHotel = const HotelEntity.empty().copyWith(
    id: '1',
    name: 'Test Hotel',
    hotelId: 'hotel123',
    isFavorite: false,
  );

  final updatedTes_tHotel = tes_tHotel.copyWith(isFavorite: true);
  final favoritesList = [tes_tHotel];

  group('AppScaffoldBloc', () {
    group('AddFavoriteEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldUpdated] when AddFavoriteEvent is successful',
        build: () {
          when(() => _mockHotelsRepository.addFavoriteHotel(hotel: tes_tHotel))
              .thenAnswer((_) async => const Right(null));

          when(() => _mockFavoritesRepository.getFavorites())
              .thenAnswer((_) async => Right(favoritesList));

          return _appScaffoldBloc;
        },
        act: (bloc) => bloc.add(AddFavoriteEvent(tes_tHotel)),
        expect: () => [
          AppScaffoldUpdated(
            hotel: updatedTes_tHotel,
            favorites: favoritesList,
          ),
        ],
      );
    });

    group('RemoveFavoriteEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldUpdated] when RemoveFavoriteEvent is successful',
        build: () {
          when(
            () => _mockHotelsRepository.removeFavoriteHotelId(
              id: tes_tHotel.hotelId,
            ),
          ).thenAnswer((_) async => const Right(null));

          when(() => _mockFavoritesRepository.getFavorites())
              .thenAnswer((_) async => Right(favoritesList));

          return _appScaffoldBloc;
        },
        act: (bloc) => bloc.add(RemoveFavoriteEvent(tes_tHotel)),
        expect: () => [
          AppScaffoldUpdated(
            hotel: tes_tHotel.copyWith(isFavorite: false),
            favorites: favoritesList,
          ),
        ],
      );
    });

    group('ResetErrorEvent', () {
      blocTest<AppScaffoldBloc, AppScaffoldState>(
        'emits [AppScaffoldInitial] when ResetErrorEvent is added',
        build: () => _appScaffoldBloc,
        act: (bloc) => bloc.add(ResetErrorEvent()),
        expect: () => [
          const AppScaffoldInitial(),
        ],
      );
    });
  });
}
