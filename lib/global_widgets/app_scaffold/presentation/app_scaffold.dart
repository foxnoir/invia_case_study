import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/screen_size.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_banner.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/widgets/app_sliver_fill.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/widgets/app_sliver_list.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.isLoading,
    required this.isLoaded,
    required this.hasError,
    required this.hotelList,
    required this.errorMessage,
    required this.onRefresh,
    required this.buttonText,
    required this.isFavoriteTab,
    this.location,
    super.key,
  });

  final String title;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final List<HotelEntity> hotelList;
  final String errorMessage;
  final Future<void> Function() onRefresh;
  final String buttonText;
  final String? location;
  final bool isFavoriteTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    ScreenSize.init(context);

    return BlocBuilder<AppScaffoldBloc, AppScaffoldState>(
      builder: (context, state) {
        var current_tHotels = hotelList;

        if (isFavoriteTab && state is AppScaffoldUpdated) {
          current_tHotels = state.favorites;
        }

        return Stack(
          children: [
            Scaffold(
              body: RefreshIndicator(
                onRefresh: onRefresh,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          title,
                          style: theme.appBarTheme.titleTextStyle,
                        ),
                      ),
                    ),
                    if (isLoading)
                      const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (current_tHotels.isEmpty && !hasError)
                      AppSliverFill(
                        img: AppImg.noFavorites,
                        message: appLocalizations?.noFavorites ??
                            FallBackString.noFavorites,
                      )
                    else if (hasError)
                      AppSliverFill(
                        img: AppImg.sadPalm,
                        message: errorMessage,
                      )
                    else
                      AppSliverList(
                        isFavoriteTab: isFavoriteTab,
                        onRefresh: onRefresh,
                        buttonText: buttonText,
                        hotelList: current_tHotels,
                        location: location,
                      ),
                  ],
                ),
              ),
            ),
            if (state is AppScaffoldError)
              AppBanner(
                onDismiss: () {
                  context.read<AppScaffoldBloc>().add(ResetErrorEvent());
                },
              ),
          ],
        );
      },
    );
  }
}
