import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';

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
          ],
        );
      },
    );
  }
}
