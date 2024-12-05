import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_card.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_cubit.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppSliverList extends StatelessWidget {
  const AppSliverList({
    required this.hotelList,
    required this.buttonText,
    this.location,
    super.key,
  });

  final List<Hotel> hotelList;
  final String buttonText;
  final String? location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final hotelsFor = localizations?.hotelFor ?? FallBackString.hotelsFor;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (location != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${hotelList.length} $hotelsFor $location',
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ...hotelList.map((hotel) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppCard(
                hotel: hotel,
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
