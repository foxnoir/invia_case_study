import 'package:auto_route/auto_route.dart';
import 'package:invia_case_study/features/account/presentaion/account_screen.dart';
import 'package:invia_case_study/features/favorites/presentaion/favorites_screen.dart';
import 'package:invia_case_study/features/hotels/presentaion/hotels_screen.dart';
import 'package:invia_case_study/features/inital_screen.dart';
import 'package:invia_case_study/features/overview/presentaion/overview_screen.dart';
import 'package:invia_case_study/features/router/app_router_consts.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: InitialRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: AppRouterPaths.overview,
              page: OverviewRoute.page,
            ),
            AutoRoute(
              path: AppRouterPaths.hotels,
              page: HotelsRoute.page,
            ),
            AutoRoute(
              path: AppRouterPaths.favorites,
              page: FavoritesRoute.page,
            ),
            AutoRoute(
              path: AppRouterPaths.account,
              page: AccountRoute.page,
            ),
          ],
        ),
      ];
}

final appRouter = AppRouter();
