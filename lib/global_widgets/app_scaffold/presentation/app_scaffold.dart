import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/screen_size.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_banner.dart';
import 'package:invia_case_study/global_widgets/app_card.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_cubit.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.isLoading,
    required this.isLoaded,
    required this.hasError,
    required this.hotels,
    required this.errorMessage,
    required this.onRefresh,
    required this.buttonText,
    required this.location,
    super.key,
  });

  final String title;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final List<Hotel> hotels;
  final String errorMessage;
  final Future<void> Function() onRefresh;
  final String buttonText;
  final String location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppScaffoldCubit, AppScaffoldState>(
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
                    else if (hasError)
                      SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImg.sadPalm,
                                height: ScreenSize.screenHeight * .4,
                              ),
                              const SizedBox(height: 35),
                              Text(
                                errorMessage,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.colorScheme.secondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      AppSliverList(
                        buttonText: buttonText,
                        hotels: hotels,
                        location: location,
                      ),
                  ],
                ),
              ),
            ),
            if (state is AppScaffoldError)
              AppBanner(
                onDismiss: () {
                  context.read<AppScaffoldCubit>().resetError();
                },
              ),
          ],
        );
      },
    );
  }
}

class AppSliverList extends StatelessWidget {
  const AppSliverList({
    required this.hotels,
    required this.buttonText,
    required this.location,
    super.key,
  });

  final List<Hotel> hotels;
  final String buttonText;
  final String location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final hotelsFor = localizations?.hotelFor ?? FallBackString.hotelsFor;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              '${hotels.length} $hotelsFor $location',
              style: theme.textTheme.headlineMedium,
            ),
          ),
          ...hotels.map((hotel) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppCard(
                imgUrl: hotel.images.isNotEmpty ? hotel.images.first.large : '',
                onButtonPressed: () {},
                onFavoritePressed: () {
                  context.read<AppScaffoldCubit>().addFavorite(hotel);
                },
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.destination,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${hotel.bestOffer.travelDate.days} Tage | ${hotel.bestOffer.travelDate.nights} Nächte',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ab ${hotel.bestOffer.total / 100} €',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                buttonText: buttonText,
              ),
            );
          }),
        ]),
      ),
    );
  }
}
