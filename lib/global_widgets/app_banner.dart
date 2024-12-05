import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/screen_size.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    this.onDismiss,
    this.alignment,
    this.verticalPadding,
  });

  final VoidCallback? onDismiss;
  final Alignment? alignment;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ScreenSize.init(context);

    return Stack(
      children: [
        Align(
          alignment: alignment ?? Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: verticalPadding ?? ScreenSize.percentualHeight * 15,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MaterialBanner(
                dividerColor: Colors.transparent,
                backgroundColor: theme.colorScheme.error.withOpacity(.9),
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    AppLocalizations.of(context)?.error ?? FallBackString.error,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColor.white_0,
                    ),
                  ),
                ),
                actions: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: TextButton(
                      onPressed: onDismiss ??
                          () => ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner(),
                      child: Icon(
                        Icons.close,
                        color: AppColor.white_0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
