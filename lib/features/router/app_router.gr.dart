// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountScreen(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesScreen(),
      );
    },
    HotelDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HotelDetailsRouteArgs>(
          orElse: () =>
              HotelDetailsRouteArgs(hotelId: pathParams.getString('hotelId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HotelDetailsScreen(hotelId: args.hotelId),
      );
    },
    HotelsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HotelsScreen(),
      );
    },
    InitialRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InitialScreen(),
      );
    },
    OverviewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OverviewScreen(),
      );
    },
  };
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HotelDetailsScreen]
class HotelDetailsRoute extends PageRouteInfo<HotelDetailsRouteArgs> {
  HotelDetailsRoute({
    required String hotelId,
    List<PageRouteInfo>? children,
  }) : super(
          HotelDetailsRoute.name,
          args: HotelDetailsRouteArgs(hotelId: hotelId),
          rawPathParams: {'hotelId': hotelId},
          initialChildren: children,
        );

  static const String name = 'HotelDetailsRoute';

  static const PageInfo<HotelDetailsRouteArgs> page =
      PageInfo<HotelDetailsRouteArgs>(name);
}

class HotelDetailsRouteArgs {
  const HotelDetailsRouteArgs({required this.hotelId});

  final String hotelId;

  @override
  String toString() {
    return 'HotelDetailsRouteArgs{hotelId: $hotelId}';
  }
}

/// generated route for
/// [HotelsScreen]
class HotelsRoute extends PageRouteInfo<void> {
  const HotelsRoute({List<PageRouteInfo>? children})
      : super(
          HotelsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HotelsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InitialScreen]
class InitialRoute extends PageRouteInfo<void> {
  const InitialRoute({List<PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OverviewScreen]
class OverviewRoute extends PageRouteInfo<void> {
  const OverviewRoute({List<PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
