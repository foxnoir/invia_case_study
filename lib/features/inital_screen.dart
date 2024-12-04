import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/router/app_router.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return AutoTabsScaffold(
      routes: const [
        OverviewRoute(),
        HotelsRoute(),
        FavoritesRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: appLocalizations?.overview ?? '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.hotel),
              label: appLocalizations?.hotels ?? '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: appLocalizations?.favorites ?? '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle),
              label: appLocalizations?.account ?? '',
            ),
          ],
        );
      },
    );
  }
}
