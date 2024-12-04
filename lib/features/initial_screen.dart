import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/router/app_router.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return AutoTabsScaffold(
      routes: const [
        OverviewRoute(),
        HotelsRoute(),
        FavoritesRoute(),
        AccountRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: AppIcon(
                assetPath: SvgIcons.overview,
                color: theme.colorScheme.tertiary,
              ),
              activeIcon: AppIcon(
                iconSize: Consts.acticveNavIconSize,
                assetPath: SvgIcons.overview,
                color: theme.colorScheme.primary,
              ),
              label: appLocalizations?.overview ?? FallBackString.overview,
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                assetPath: SvgIcons.hotel,
                color: theme.colorScheme.tertiary,
              ),
              activeIcon: AppIcon(
                iconSize: Consts.acticveNavIconSize,
                assetPath: SvgIcons.hotel,
                color: theme.colorScheme.primary,
              ),
              label: appLocalizations?.hotels ?? FallBackString.hotels,
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                assetPath: SvgIcons.favorite,
                color: theme.colorScheme.tertiary,
              ),
              activeIcon: AppIcon(
                iconSize: Consts.acticveNavIconSize,
                assetPath: SvgIcons.favorite,
                color: theme.colorScheme.primary,
              ),
              label: appLocalizations?.favorites ?? FallBackString.favorites,
            ),
            BottomNavigationBarItem(
              icon: AppIcon(
                assetPath: SvgIcons.account,
                color: theme.colorScheme.tertiary,
              ),
              activeIcon: AppIcon(
                iconSize: Consts.acticveNavIconSize,
                assetPath: SvgIcons.account,
                color: theme.colorScheme.primary,
              ),
              label: appLocalizations?.account ?? FallBackString.account,
            ),
          ],
        );
      },
    );
  }
}
