import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class AppCardDetailsSection extends StatelessWidget {
  const AppCardDetailsSection({
    required this.hotel,
    super.key,
  });

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Consts.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StarRating(
                rating: hotel.ratingInfo.score,
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
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({
    required this.rating,
    super.key,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = rating - index;
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
