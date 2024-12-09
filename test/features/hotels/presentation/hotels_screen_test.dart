// Unit Test file for hotels_screen.dartimport 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/hotels/presentation/hotels_screen.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/app_scaffold.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';
import 'package:mocktail/mocktail.dart';

import '../../../di/test_di.config.dart';
import '../../../di/test_di.dart';
import '../../../global_widgets/app_scaffold/presentation/app_scaffold_test.dart';
import 'bloc/hotels_bloc_test.dart';

void main() {
  late HotelsBloc _hotelsBloc;
  late MockHotelsRepository _mockHotelsRepository;
  late MockAppScaffoldBloc _mockAppScaffoldBloc;

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() async {
    await TestDI.getIt.reset();
    TestDI.getIt.initTest();

    _mockHotelsRepository = MockHotelsRepository();
    _mockAppScaffoldBloc = MockAppScaffoldBloc();

    TestDI.getIt.registerSingleton<HotelsRepository>(_mockHotelsRepository);
    TestDI.getIt.registerSingleton<AppScaffoldBloc>(_mockAppScaffoldBloc);

    _hotelsBloc = HotelsBloc(hotelsRepository: _mockHotelsRepository);

    when(() => _mockAppScaffoldBloc.state)
        .thenReturn(const AppScaffoldInitial());

    final hotelsList = [
      const HotelEntity.empty().copyWith(name: 'Hotel 1'),
      const HotelEntity.empty().copyWith(name: 'Hotel 2'),
    ];

    when(() => _mockHotelsRepository.getHotels())
        .thenAnswer((_) async => Right(hotelsList));
  });

  tearDown(() async {
    await _hotelsBloc.close();
    await _mockAppScaffoldBloc.close();
    await TestDI.getIt.reset();
  });

  group('HotelsScreen', () {
    testWidgets('should display elements correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HotelsBloc>(
                create: (_) => _hotelsBloc,
              ),
              BlocProvider<AppScaffoldBloc>(
                create: (_) => _mockAppScaffoldBloc,
              ),
            ],
            child: const HotelsScreen(),
          ),
        ),
      );

      expect(find.byType(AppScaffold), findsOneWidget);
      expect(find.text(FallBackString.hotels), findsOneWidget);
    });
  });
}
