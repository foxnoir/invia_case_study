import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invia_case_study/features/account/presentation/account_screen.dart';
import 'package:invia_case_study/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:invia_case_study/features/favorites/presentation/favorites_screen.dart';
import 'package:invia_case_study/features/hotel_details/hotel_details_screen.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/hotels/presentation/hotels_screen.dart';
import 'package:invia_case_study/features/initial_screen.dart';
import 'package:invia_case_study/features/overview/overview_screen.dart';
import 'package:invia_case_study/features/router/app_router.dart';
import 'package:invia_case_study/features/router/app_router_paths.dart';

class MockHotelsBloc extends MockBloc<HotelsEvent, HotelsState>
    implements HotelsBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  late AppRouter appRouter;

  setUp(() {
    appRouter = AppRouter();
  });

  group('AppRouter', () {
    test('should have an initial route', () {
      final initialRoute = appRouter.routes.first;
      expect(initialRoute.path, '/');
      expect(initialRoute.name, InitialRoute.page.name);
      expect(initialRoute.initial, true);
    });

    test('should have the correct children for the initial route', () {
      final children = appRouter.routes.first.children!.routes;
      final childPaths = children.map((route) => route.path).toList();

      expect(
        childPaths,
        containsAll([
          AppRouterPaths.overview,
          AppRouterPaths.hotels,
          AppRouterPaths.favorites,
          AppRouterPaths.account,
        ]),
      );
    });

    test(
        'should define the hotel details route with optional hotelId parameter',
        () {
      final hotelDetailsRoute = appRouter.routes.firstWhere(
        (route) => route.path == '${AppRouterPaths.hotelDetails}:hotelId?',
      );

      expect(hotelDetailsRoute.path, '${AppRouterPaths.hotelDetails}:hotelId?');
      expect(hotelDetailsRoute.name, 'HotelDetailsRoute');
    });

    testWidgets(
      'should show [OverviewScreen] when the initial route is loaded',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(InitialScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should show to the [HotelDetailsScreen] when tapping on a hotel',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(HotelDetailsRoute(hotelId: '123')));
        await tester.pumpAndSettle();

        expect(find.byType(HotelDetailsScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should show to [FavoritesScreen] when tapping on [favorites]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(const FavoritesRoute()));

        await tester.pumpAndSettle();

        expect(find.byType(FavoritesScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should show to [AccountScreen] when tapping on [account]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(const AccountRoute()));
        await tester.pumpAndSettle();

        expect(find.byType(AccountScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should show to [OverviewScreen] when tapping on [overview]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(const OverviewRoute()));
        await tester.pumpAndSettle();

        expect(find.byType(OverviewScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should show to [HotelsScreen] when tapping on [hotels]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(const HotelsRoute()));

        await tester.pumpAndSettle();

        expect(find.byType(HotelsScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should pass hotelId to [HotelDetailsScreen] '
      'when push [HotelDetailsRoute]',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(HotelDetailsRoute(hotelId: '123')));
        await tester.pumpAndSettle();

        expect(find.byType(HotelDetailsScreen), findsOneWidget);
      },
    );

    testWidgets(
      'should pop back to the previous screen pop Screen',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: appRouter.config(),
          ),
        );

        unawaited(appRouter.push(const FavoritesRoute()));
        await tester.pumpAndSettle();

        expect(find.byType(FavoritesScreen), findsOneWidget);

        unawaited(appRouter.maybePop());
        await tester.pumpAndSettle();

        expect(find.byType(InitialScreen), findsOneWidget);
      },
    );
  });
}
