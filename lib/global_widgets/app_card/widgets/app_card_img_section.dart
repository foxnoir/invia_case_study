import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_state.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppCardImgSection extends StatelessWidget {
  const AppCardImgSection({
    required this.imgUrl,
    required this.hotel,
    this.isFavoriteTab = false,
    this.content,
    super.key,
  });

  final String imgUrl;
  final Widget? content;
  final HotelEntity hotel;
  final bool? isFavoriteTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    final scoreDescription =
        ScoreDescription.fromString(hotel.ratingInfo.scoreDescription);

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
                    child: isFavorite
                        ? AppIcon(
                            key: const ValueKey('favorite_fillled'),
                            assetPath: SvgIcon.favoriteFilled,
                            color: theme.colorScheme.surface,
                          )
                        : AppIcon(
                            key: const ValueKey('favorite'),
                            assetPath: SvgIcon.favorite,
                            color: theme.colorScheme.tertiary,
                          ),
                  ),
                ),
              ),
            ),
            if (isFavoriteTab!)
              Positioned(
                left: 10,
                bottom: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: scoreDescription.color,
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
                    const SizedBox(width: 12),
                    Text(
                      hotel.ratingInfo.scoreDescription,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.surface,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                    Text(
                      ' (${hotel.ratingInfo.reviewsCount} '
                      '${appLocalizations?.rating ?? FallBackString.rating})',
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

enum ScoreDescription {
  noDesc,
  excellent,
  veryGood,
  adequate,
  weak;

  static ScoreDescription fromString(String description) {
    switch (description) {
      case 'Ausgezeichnet':
        return ScoreDescription.excellent;
      case 'Sehr Gut':
        return ScoreDescription.veryGood;
      case 'Angemessen':
        return ScoreDescription.adequate;
      case 'Schwach':
        return ScoreDescription.weak;
      default:
        return ScoreDescription.noDesc;
    }
  }

  Color get color {
    switch (this) {
      case ScoreDescription.excellent:
      case ScoreDescription.veryGood:
        return AppColor.light_green;
      case ScoreDescription.adequate:
      case ScoreDescription.weak:
        return AppColor.error;
      case ScoreDescription.noDesc:
        return AppColor.box_grey;
    }
  }
}
