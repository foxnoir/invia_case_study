import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_banner.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
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
    this.location,
    super.key,
  });

  final String title;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final List<Hotel> hotelList;
  final String errorMessage;
  final Future<void> Function() onRefresh;
  final String buttonText;
  final String? location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<AppScaffoldBloc, AppScaffoldState>(
      builder: (context, state) {
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
                    else if (hotelList.isEmpty)
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
                        onRefresh: onRefresh,
                        buttonText: buttonText,
                        hotelList: hotelList,
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
