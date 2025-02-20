// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/screen_size.dart';
import 'package:invia_case_study/core/utils/formatter.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_card/app_card_star_rating.dart';
import 'package:invia_case_study/global_widgets/app_card/widgets/app_card_details_text_row.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppCardDetailsSection extends StatelessWidget {
  const AppCardDetailsSection({
    required this.hotel,
    this.isFavoriteTab = false,
    super.key,
  });

  final HotelEntity hotel;
  final bool? isFavoriteTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    ScreenSize.init(context);

    final days = hotel.bestOffer.travelDate.days;
    final finalDays = days < 2
        ? '$days ${appLocalizations?.day ?? FallBackString.day}'
        : '$days ${appLocalizations?.days ?? FallBackString.days}';
    final nights = hotel.bestOffer.travelDate.nights;
    final finalNights = nights < 2
        ? '$nights ${appLocalizations?.night ?? FallBackString.night}'
        : '$nights ${appLocalizations?.nights ?? FallBackString.nights}';
    final travelers = '${hotel.bestOffer.overallRoomDetails.adultCount} '
        ' ${appLocalizations?.adults ?? FallBackString.adults}, '
        '${hotel.bestOffer.overallRoomDetails.childrenCount} '
        '${appLocalizations?.children ?? FallBackString.children}';
    final flight = hotel.bestOffer.flightIncluded
        ? '${appLocalizations?.including ?? FallBackString.including} '
            '${appLocalizations?.flight ?? FallBackString.flight}'
        : '${appLocalizations?.without ?? FallBackString.without} '
            '${appLocalizations?.flight ?? FallBackString.flight}';

    return Padding(
      padding: const EdgeInsets.all(Consts.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppCardStarRating(
                category: hotel.category,
              ),
              const SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                SvgIcon.help,
                width: Consts.cardIconSize,
                height: Consts.cardIconSize,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.tertiary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            hotel.name,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            hotel.destination,
            style: theme.textTheme.bodyMedium,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Consts.cardPadding),
            child: Divider(),
          ),
          if (!isFavoriteTab!)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCardDetailsTextRow(
                        context: context,
                        leftText: finalDays,
                        rightText: finalNights,
                      ),
                      if (hotel.bestOffer.roomGroups.isNotEmpty)
                        AppCardDetailsTextRow(
                          context: context,
                          leftText:
                              '${hotel.bestOffer.roomGroups.first.name}  ',
                          rightText:
                              '  ${hotel.bestOffer.roomGroups.first.boarding}',
                        ),
                      AppCardDetailsTextRow(
                        context: context,
                        leftText: travelers,
                        rightText: flight,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${appLocalizations?.prizeFrom ?? FallBackString.prizeFrom} ',
                              style: theme.textTheme.bodySmall,
                            ),
                            TextSpan(
                              text:
                                  '${Formatter.formatPrice(priceInCents: hotel.bestOffer.total)} €',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: ScreenSize.screenWidth < 430
                                    ? AppFontSize.s18
                                    : AppFontSize.s23,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${Formatter.formatPrice(priceInCents: hotel.bestOffer.simplePricePerPerson)} € p.P',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
