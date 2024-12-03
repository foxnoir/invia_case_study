import 'package:auto_route/auto_route.dart';
import 'package:invia_case_study/features/account/presentaion/account_screen.dart';
import 'package:invia_case_study/features/favorites/presentaion/favorites_screen.dart';
import 'package:invia_case_study/features/hotels/presentaion/hotels_screen.dart';
import 'package:invia_case_study/features/inital_screen.dart';
import 'package:invia_case_study/features/overview/presentaion/overview_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: InitialRoute.page, // Die InitialScreen ist korrekt verknüpft
          initial: true,
          children: [
            AutoRoute(
              path: 'overview',
              page: OverviewRoute.page, // Kinder-Routen korrekt verknüpft
            ),
            AutoRoute(
              path: 'hotels',
              page: HotelsRoute.page,
            ),
            AutoRoute(
              path: 'favorites',
              page: FavoritesRoute.page,
            ),
            AutoRoute(
              path: 'account',
              page: AccountRoute.page,
            ),
          ],
        ),
      ];
}

final appRouter = AppRouter();
