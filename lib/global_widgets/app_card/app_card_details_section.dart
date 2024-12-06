// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/router/app_router.dart';
import 'package:invia_case_study/features/router/app_router_paths.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppCardDetailsSection extends StatelessWidget {
  const AppCardDetailsSection({
    required this.hotel,
    this.isFavoriteTab = false,
    super.key,
  });

  final Hotel hotel;
  final bool? isFavoriteTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    final days = hotel.bestOffer.travelDate.days;
    final finalDays = days < 2
        ? '$days ${appLocalizations?.day ?? FallBackString.day}  '
        : '$days ${appLocalizations?.days ?? FallBackString.days}  ';
    final nights = hotel.bestOffer.travelDate.nights;
    final finalNights = nights < 2
        ? '  $nights ${appLocalizations?.night ?? FallBackString.night}'
        : '  $nights ${appLocalizations?.nights ?? FallBackString.nights}';

    String _formatPrice({required int priceInCents}) {
      final euros = priceInCents ~/ 100;
      final cents = priceInCents % 100;
      return '$euros,${cents.toString().padLeft(2, '0')}';
    }

    return Padding(
      padding: const EdgeInsets.all(Consts.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StarRating(
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
            style: theme.textTheme.headlineLarge,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextRow(
                        context: context,
                        leftText: finalDays,
                        rightText: finalNights),
                    if (hotel.bestOffer.roomGroups.isNotEmpty)
                      _buildTextRow(
                        context: context,
                        leftText: '${hotel.bestOffer.roomGroups.first.name}  ',
                        rightText:
                            '  ${hotel.bestOffer.roomGroups.first.boarding}',
                      ),
                    Text(
                      '2 Erw., 2 Kinder | inkl. Flug',
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${appLocalizations?.prizeFrom ?? FallBackString.prizeFrom} '
                      '${_formatPrice(priceInCents: hotel.bestOffer.total)} €',
                      style: theme.textTheme.headlineLarge
                          ?.copyWith(fontSize: AppFontSize.s23),
                    ),
                    Text(
                      '${_formatPrice(priceInCents: hotel.bestOffer.simplePricePerPerson)} € p.P',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }

  Padding _buildTextRow({
    required String leftText,
    required String rightText,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            leftText,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(
            height: 18,
            child: VerticalDivider(
              color: AppColor.grey.withOpacity(.4),
              thickness: 1,
              width: 1,
            ),
          ),
          Text(
            rightText,
            style: theme.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({
    required this.category,
    super.key,
  });
  final int category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = category - index;
        Color starColor;

        if (starValue >= 1) {
          starColor = AppColor.grey;
        } else {
          starColor = createMaterialColor(color: AppColor.light_grey).shade600;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: SvgPicture.asset(
            SvgIcon.star,
            width: Consts.cardIconSize,
            height: Consts.cardIconSize,
            colorFilter: ColorFilter.mode(starColor, BlendMode.srcIn),
          ),
        );
      }),
    );
  }
}
