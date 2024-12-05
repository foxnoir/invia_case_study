import 'package:flutter/material.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/global_widgets/app_icon.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.imgUrl,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onFavoritePressed,
    super.key,
  });

  final String imgUrl;
  final Widget content;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  imgUrl.isNotEmpty ? imgUrl : AppImg.placeHolder,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    logger.i(error.toString());
                    return const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(AppImg.placeHolder),
                    );
                  },
                ),
              ),
              Positioned(
                top: 11,
                right: 15,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(.7),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onFavoritePressed,
                      customBorder: const CircleBorder(),
                      splashColor: AppColor.grey.withOpacity(.1),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: AppIcon(
                          assetPath: SvgIcon.favorite,
                          color: theme.colorScheme.tertiary,
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
                onPressed: () {},
                child: Text(
                  buttonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
