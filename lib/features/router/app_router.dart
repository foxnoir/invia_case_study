import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/features/account/presentation/account_screen.dart';
import 'package:invia_case_study/features/favorites/presentation/favorites_screen.dart';
import 'package:invia_case_study/features/hotel_details/hotel_details_screen.dart';
import 'package:invia_case_study/features/hotels/presentation/hotels_screen.dart';
import 'package:invia_case_study/features/initial_screen.dart';
import 'package:invia_case_study/features/overview/overview_screen.dart';
import 'package:invia_case_study/features/router/app_router_paths.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: InitialRoute.page,
          initial: true,
          children: [
            AutoRoute(path: AppRouterPaths.overview, page: OverviewRoute.page),
            AutoRoute(path: AppRouterPaths.hotels, page: HotelsRoute.page),
            AutoRoute(
              path: AppRouterPaths.favorites,
              page: FavoritesRoute.page,
            ),
            AutoRoute(path: AppRouterPaths.account, page: AccountRoute.page),
          ],
        ),
        AutoRoute(
          path: '${AppRouterPaths.hotelDetails}:hotelId?',
          page: HotelDetailsRoute.page,
        ),
      ];
}

final appRouter = AppRouter();
