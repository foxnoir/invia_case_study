import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/router/app_router.dart';
import 'package:invia_case_study/features/router/app_router_paths.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppCardImgSection extends StatelessWidget {
  const AppCardImgSection({
    required this.imgUrl,
    required this.hotel,
    this.content,
    super.key,
  });

  final String imgUrl;
  final Widget? content;
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hotelRating = hotel.analytics.itemCategory;
    final ratingInfo = RatingMapper.getRatingInfo(hotelRating, context);
    final ratingString =
        AppLocalizations.of(context)?.rating ?? FallBackString.rating;

    return BlocBuilder<AppScaffoldBloc, AppScaffoldState>(
      buildWhen: (previous, current) =>
          current is AppScaffoldUpdated &&
          current.hotel.hotelId == hotel.hotelId,
      builder: (context, state) {
        final isFavorite = (state is AppScaffoldUpdated &&
                state.hotel.hotelId == hotel.hotelId)
            ? state.hotel.isFavorite
            : hotel.isFavorite;

        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Image(
                  image: AssetImage('assets/placeholder.png'),
                ),
              ),
            ),
            Positioned(
              top: 11,
              right: 17,
              child: GestureDetector(
                onTap: () {
                  context.read<AppScaffoldBloc>().add(
                        isFavorite
                            ? RemoveFavoriteEvent(hotel)
                            : AddFavoriteEvent(hotel),
                      );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface
                        .withOpacity(isFavorite ? 0.1 : 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: AppIcon(
                      assetPath: isFavorite
                          ? SvgIcon.favoriteFilled
                          : SvgIcon.favorite,
                      color: isFavorite
                          ? theme.colorScheme.surface
                          : theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ),
            if (appRouter.currentPath == '/${AppRouterPaths.favorites}')
              Positioned(
                left: 10,
                bottom: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ratingInfo.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            SvgIcon.smile,
                            width: Consts.cardIconSize,
                            height: Consts.cardIconSize,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.surface,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${hotel.ratingInfo.score} / 5.0',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.surface,
                              fontWeight: AppFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      ratingInfo.text,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.surface,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                    Text(
                      ' (${hotel.ratingInfo.reviewsCount} $ratingString)',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.surface,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class RatingMapper {
  static RatingInfo getRatingInfo(String itemCategory, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final keywords = itemCategory.split(',').map((s) => s.trim());

    for (final keyword in keywords) {
      if (keyword == 'highlySatisfied') {
        return RatingInfo(
          text: appLocalizations?.ratingHighlySatisfied ??
              FallBackString.ratingHighlySatisfied,
          color: AppColor.light_green,
        );
      } else if (keyword == 'verySatisfied') {
        return RatingInfo(
          text: appLocalizations?.ratingVerySatisfied ??
              FallBackString.ratingVerySatisfied,
          color: AppColor.light_green,
        );
      } else if (keyword == 'satisfied') {
        return RatingInfo(
          text: appLocalizations?.ratingSatisfied ??
              FallBackString.ratingSatisfied,
          color: AppColor.light_green,
        );
      } else if (keyword == 'dissatisfied') {
        return RatingInfo(
          text: appLocalizations?.ratingDissatisfied ??
              FallBackString.ratingDissatisfied,
          color: AppColor.error,
        );
      } else if (keyword == 'veryDissatisfied') {
        return RatingInfo(
          text: appLocalizations?.ratingVeryDissatisfied ??
              FallBackString.ratingVeryDissatisfied,
          color: AppColor.error,
        );
      }
    }

    return RatingInfo(
      text: '',
      color: Colors.grey,
    );
  }
}

class RatingInfo {
  RatingInfo({required this.text, required this.color});
  final String text;
  final Color color;
}
