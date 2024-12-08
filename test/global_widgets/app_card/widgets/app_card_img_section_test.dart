import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_card/widgets/app_card_img_section.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAppScaffoldBloc extends Mock implements AppScaffoldBloc {}

class FakeRemoveFavoriteEvent extends Fake implements RemoveFavoriteEvent {}

class FakeAddFavoriteEvent extends Fake implements AddFavoriteEvent {}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  late MockAppScaffoldBloc _mockAppScaffoldBloc;
  late Hotel _hotel;

  setUpAll(() {
    registerFallbackValue(FakeRemoveFavoriteEvent());
    registerFallbackValue(FakeAddFavoriteEvent());
  });

  setUp(() {
    _mockAppScaffoldBloc = MockAppScaffoldBloc();
    _hotel = const Hotel.empty().copyWith(
      id: '1',
      name: 'Test Hotel',
      hotelId: 'hotel_1',
      ratingInfo: const RatingInfo(
        score: 4.5,
        reviewsCount: 120,
        scoreDescription: 'Ausgezeichnet',
      ),
    );

    when(() => _mockAppScaffoldBloc.stream)
        .thenAnswer((_) => Stream.value(const AppScaffoldInitial()));
    when(() => _mockAppScaffoldBloc.state)
        .thenReturn(const AppScaffoldInitial());

    HttpOverrides.global = TestHttpOverrides();
  });

  tearDown(() {
    HttpOverrides.global = null;
  });

  Widget createAppCardTestWidget({bool isFavorite = true}) {
    return MaterialApp(
      home: BlocProvider<AppScaffoldBloc>.value(
        value: _mockAppScaffoldBloc,
        child: AppCardImgSection(
          isFavoriteTab: true,
          imgUrl: 'https://example.com/image.jpg',
          hotel: _hotel.copyWith(isFavorite: isFavorite),
        ),
      ),
    );
  }

  group('AppCardImgSection', () {
    testWidgets(
        'taps on favorite button and triggers '
        'RemoveFavoriteEvent if already favorite', (tester) async {
      await tester.pumpWidget(createAppCardTestWidget());

      expect(find.byKey(const ValueKey('favorite_fillled')), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      verify(() => _mockAppScaffoldBloc.add(any<RemoveFavoriteEvent>()))
          .called(1);
    });

    testWidgets('displays filled heart icon when hotel is a favorite',
        (tester) async {
      await tester.pumpWidget(createAppCardTestWidget());

      expect(find.byKey(const ValueKey('favorite_fillled')), findsOneWidget);
      expect(find.byKey(const ValueKey('favorite')), findsNothing);
    });

    testWidgets('displays outline heart icon when hotel is not favorite',
        (tester) async {
      await tester.pumpWidget(createAppCardTestWidget(isFavorite: false));

      expect(find.byKey(const ValueKey('favorite_fillled')), findsNothing);
      expect(find.byKey(const ValueKey('favorite')), findsOneWidget);
    });

    testWidgets(
        'taps on favorite button and triggers AddFavoriteEvent if not favorite',
        (tester) async {
      await tester.pumpWidget(createAppCardTestWidget(isFavorite: false));

      expect(find.byKey(const ValueKey('favorite')), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      verify(() => _mockAppScaffoldBloc.add(any<AddFavoriteEvent>())).called(1);
    });
  });
}
