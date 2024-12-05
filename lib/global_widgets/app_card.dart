import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/bloc/app_scaffold_bloc.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.imgUrl,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    required this.hotel,
    super.key,
  });

  final String imgUrl;
  final Widget content;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppScaffoldBloc, AppScaffoldState>(
      buildWhen: (previous, current) {
        if (current is AppScaffoldUpdated) {
          return current.hotel.hotelId == hotel.hotelId;
        }
        return false;
      },
      builder: (context, state) {
        bool isFavorite = hotel.isFavorite;

        if (state is AppScaffoldUpdated &&
            state.hotel.hotelId == hotel.hotelId) {
          isFavorite = state.hotel.isFavorite;
        }

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Image(
                        image: AssetImage('assets/placeholder.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 11,
                    right: 15,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface
                            .withOpacity(isFavorite ? .1 : .7),
                        shape: BoxShape.circle,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<AppScaffoldBloc>().add(
                                  isFavorite
                                      ? RemoveFavoriteEvent(hotel)
                                      : AddFavoriteEvent(hotel),
                                );
                          },
                          customBorder: const CircleBorder(),
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: content,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(buttonText),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
