import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:invia_case_study/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:invia_case_study/features/favorites/presentation/favorites_screen.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/app_scaffold.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';
import 'package:mocktail/mocktail.dart';

import '../../../di/test_di.config.dart';
import '../../../di/test_di.dart';
import 'bloc/favorites_bloc_test.dart';

class MockAppScaffoldBloc extends MockBloc<AppScaffoldEvent, AppScaffoldState>
    implements AppScaffoldBloc {}

void main() {
  late FavoritesBloc _favoritesBloc;
  late MockFavoritesRepository _mockFavoritesRepository;
  late MockAppScaffoldBloc _mockAppScaffoldBloc;

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() async {
    await TestDI.getIt.reset();
    TestDI.getIt.initTest();

    _mockFavoritesRepository = MockFavoritesRepository();
    _mockAppScaffoldBloc = MockAppScaffoldBloc();

    TestDI.getIt
        .registerSingleton<FavoritesRepository>(_mockFavoritesRepository);
    TestDI.getIt.registerSingleton<AppScaffoldBloc>(_mockAppScaffoldBloc);

    _favoritesBloc =
        FavoritesBloc(favoritesRepository: _mockFavoritesRepository);

    when(() => _mockAppScaffoldBloc.state)
        .thenReturn(const AppScaffoldInitial());

    final _hotelsList = [
      const HotelEntity.empty().copyWith(name: 'Hotel 1'),
      const HotelEntity.empty().copyWith(name: 'Hotel 2'),
    ];

    when(() => _mockFavoritesRepository.getFavorites())
        .thenAnswer((_) async => Right(_hotelsList));
  });

  tearDown(() async {
    await _favoritesBloc.close();
    await _mockAppScaffoldBloc.close();
    await TestDI.getIt.reset();
  });

  group('FavoritesScreen', () {
    testWidgets('should display elements correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<FavoritesBloc>(
                create: (_) => _favoritesBloc,
              ),
              BlocProvider<AppScaffoldBloc>(
                create: (_) => _mockAppScaffoldBloc,
              ),
            ],
            child: const FavoritesScreen(),
          ),
        ),
      );

      expect(find.byType(AppScaffold), findsOneWidget);
      expect(find.text(FallBackString.favorites), findsOneWidget);
    });
  });
}
