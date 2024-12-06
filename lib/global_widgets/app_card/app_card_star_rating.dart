import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';

class AppCardStarRating extends StatelessWidget {
  const AppCardStarRating({
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
