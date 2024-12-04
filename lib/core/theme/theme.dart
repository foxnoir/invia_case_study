import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';

ThemeData getLightTheme() {
  return _theme(_getColorScheme(Brightness.light));
}

ThemeData _theme(ColorScheme colorScheme) {
  final textTheme = TextTheme(
    // hotel names
    headlineLarge: TextStyle(
      fontSize: AppFontSize.xLarge,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onSurface,
    ),
    // nav bar
    headlineMedium: TextStyle(
      fontSize: AppFontSize.large,
      fontWeight: AppFontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    // bottom nav
    labelSmall: TextStyle(
      fontSize: AppFontSize.small,
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
      titleTextStyle: textTheme.headlineMedium,
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

    // TextButton Theme
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     backgroundColor:
    //         WidgetStateProperty.all(createMaterialColor(colorScheme.primary)),
    //     minimumSize: btnSize,
    //     maximumSize: btnSize,
    //     shape: btnRadius,
    //     foregroundColor: WidgetStateProperty.all(
    //       createMaterialColor(colorScheme.tertiary),
    //     ),
    //     overlayColor: WidgetStateProperty.all(
    //       createMaterialColor(colorScheme.tertiary).withOpacity(0.1),
    //     ),
    //     textStyle: Consts.btnTextStyle,
    //   ),
    // ),

    // OutlinedButton Theme
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: ButtonStyle(
    //     side: WidgetStateProperty.all(
    //       BorderSide(
    //         color: createMaterialColor(colorScheme.primary),
    //       ),
    //     ),
    //     backgroundColor: WidgetStateProperty.all(
    //       createMaterialColor(colorScheme.tertiary),
    //     ),
    //     minimumSize: btnSize,
    //     maximumSize: btnSize,
    //     shape: btnRadius,
    //     foregroundColor: WidgetStateProperty.all(
    //       createMaterialColor(colorScheme.primary),
    //     ),
    //     overlayColor: WidgetStateProperty.all(
    //       createMaterialColor(colorScheme.primary).withOpacity(0.1),
    //     ),
    //     textStyle: Consts.btnTextStyle,
    //   ),
    // ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColor.light_grey,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    ),

    // Dialog Theme
    // dialogTheme: DialogTheme(
    //   surfaceTintColor: colorScheme.tertiary,
    //   shadowColor: AppColor.grey_100,
    //   titleTextStyle: Consts.dialogTitleTextStyle,
    //   contentTextStyle: Consts.dialogContentTextStyle,
    //   elevation: Consts.elevation,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    // ),

    // cardTheme: CardTheme(
    //   color: AppColor.white_0,
    //   surfaceTintColor: AppColor.white_0,
    //   shadowColor: AppColor.grey_100,
    //   elevation: Consts.elevation,
    // ),

    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(Consts.globalContentPaddingS),
    //   fillColor: Colors.transparent,
    //   hintStyle: TextStyle(
    //     fontWeight: AppFontWeight.medium,
    //     fontSize: AppFontSize.medium,
    //     color: AppColor.grey_300,
    //   ),
    //   labelStyle: TextStyle(
    //     fontWeight: AppFontWeight.medium,
    //     fontSize: AppFontSize.large,
    //     color: AppColor.magenta,
    //   ),
    //   errorStyle: TextStyle(
    //     fontWeight: AppFontWeight.medium,
    //     fontSize: AppFontSize.medium,
    //     color: AppColor.red,
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.grey_300),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.magenta),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.red),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.magenta),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    // ),
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
