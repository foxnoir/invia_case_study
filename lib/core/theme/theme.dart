import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';

ThemeData getLightTheme() {
  return _theme(_getColorScheme(Brightness.light));
}

ThemeData _theme(ColorScheme colorScheme) {
  final textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: AppFontSize.xLarge,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onSurface,
    ),
    // hotel count
    headlineMedium: TextStyle(
      fontSize: AppFontSize.s19,
      fontWeight: AppFontWeight.bold,
      color: AppColor.grey,
    ),
    // app bar
    headlineSmall: TextStyle(
      fontSize: AppFontSize.s17,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    // bottom nav
    labelSmall: TextStyle(
      fontSize: AppFontSize.s12,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
    // buttons
    labelMedium: TextStyle(
      fontSize: AppFontSize.s16,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSize.s14,
      fontWeight: AppFontWeight.medium,
      color: colorScheme.tertiary,
    ),
  );
  final themeData = ThemeData(
    fontFamily: AppFont.fontFamily,
    primaryColor: colorScheme.primary,
    secondaryHeaderColor: colorScheme.secondary,
    disabledColor: AppColor.dark_grey,
    scaffoldBackgroundColor: colorScheme.surface,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
    textTheme: textTheme,
    iconTheme: IconThemeData(
      color: colorScheme.onSurface,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: colorScheme.primary,
      elevation: 0,
      titleTextStyle: textTheme.headlineSmall,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: textTheme.labelSmall?.copyWith(
        color: colorScheme.primary,
      ),
      selectedItemColor: colorScheme.primary,
      showUnselectedLabels: true,
      unselectedItemColor: colorScheme.tertiary,
      unselectedLabelStyle: textTheme.labelSmall,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColor.light_grey,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    ),

    cardTheme: CardTheme(
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        textStyle: textTheme.labelMedium,
      ),
    ),
  );
  return themeData;
}

ColorScheme _getColorScheme(Brightness brightness) {
  final lightColorScheme = ColorScheme.light(
    primary: AppColor.dark_blue,
    secondary: AppColor.orange,
    tertiary: AppColor.dark_grey,
    surface: AppColor.white_0,
    error: AppColor.error,
    outline: AppColor.light_grey,
    onPrimary: AppColor.white_0,
    onSurface: AppColor.grey,
  );
  return lightColorScheme;
}
