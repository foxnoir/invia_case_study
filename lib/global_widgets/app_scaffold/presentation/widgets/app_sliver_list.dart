import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_card/app_card.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppSliverList extends StatelessWidget {
  const AppSliverList({
    required this.hotelList,
    required this.buttonText,
    required this.onRefresh,
    this.location,
    super.key,
  });

  final List<Hotel> hotelList;
  final String buttonText;
  final String? location;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    final locatedString =
        appLocalizations?.hotelFor ?? FallBackString.hotelsFor;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (location != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${hotelList.length} $locatedString $location',
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ...hotelList.map((hotel) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: AppCard(
                hotel: hotel,
                imgUrl: hotel.images.isNotEmpty ? hotel.images.first.large : '',
                onButtonPressed: () {},
                content: Container(),
                buttonText: buttonText,
              ),
            );
          }),
        ]),
      ),
    );
  }
}
