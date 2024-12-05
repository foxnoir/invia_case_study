import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/screen_size.dart';

class AppSliverFill extends StatelessWidget {
  const AppSliverFill({
    required this.img,
    required this.message,
    super.key,
  });

  final String img;
  final String message;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final theme = Theme.of(context);

    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: ScreenSize.screenHeight * .4,
            ),
            const SizedBox(height: 35),
            Text(
              message,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
