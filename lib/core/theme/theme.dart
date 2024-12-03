import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/colours.dart';
import 'package:invia_case_study/core/theme/const.dart';
import 'package:invia_case_study/core/theme/fonts.dart';

ThemeData getLightTheme() {
  return _theme(_getColorScheme(Brightness.light));
}

ThemeData _theme(ColorScheme colorScheme) {
  final btnSize = WidgetStateProperty.all(
    Size(Consts.primaryBtnWidthS, Consts.btnHeightL),
  );

  final btnRadius = WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Consts.radius),
    ),
  );

  final themeData = ThemeData(
    fontFamily: Font.fontFamily,
    primaryColor: colorScheme.primary,
    secondaryHeaderColor: colorScheme.secondary,
    disabledColor: Colours.grey_600,
    scaffoldBackgroundColor: colorScheme.tertiary,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: FontSize.xLarge,
        fontWeight: FontWeights.medium,
        color: colorScheme.secondary,
      ),
      headlineMedium: TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.bold,
        color: colorScheme.secondary,
      ),
      headlineSmall: TextStyle(
        fontSize: FontSize.medium,
        fontWeight: FontWeights.bold,
        color: colorScheme.secondary,
      ),
      titleLarge: const TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.light,
      ),
      titleMedium: TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.medium,
        color: colorScheme.secondary,
      ),
      titleSmall: TextStyle(
        color: colorScheme.tertiary,
        fontSize: FontSize.tiny,
        fontWeight: FontWeights.medium,
      ),
      bodyLarge: const TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.medium,
      ),
      bodyMedium: const TextStyle(
        fontSize: FontSize.medium,
        fontWeight: FontWeights.medium,
      ),
      labelLarge: TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.medium,
        color: colorScheme.tertiary,
      ),
      labelMedium: TextStyle(
        fontSize: FontSize.small,
        fontWeight: FontWeights.light,
        color: Colours.grey_400,
      ),
      labelSmall: const TextStyle(
        fontSize: FontSize.tiny,
        fontWeight: FontWeights.light,
      ),
    ),
    iconTheme: IconThemeData(color: colorScheme.onSurface),

    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colours.magenta),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      checkColor: WidgetStateProperty.all<Color>(
        createMaterialColor(Colours.magenta),
      ),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: colorScheme.tertiary,
      surfaceTintColor: colorScheme.tertiary,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colours.grey_700, //change your color here
      ),
      shadowColor: colorScheme.tertiary,
      titleTextStyle: TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.bold,
        color: colorScheme.secondary,
      ),
      shape: Border(
        bottom: BorderSide(
          color: Colours.grey_300.withOpacity(0.5),
          width: Consts.borderThick,
        ),
      ),
    ),

    // BottomNavigationBar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: Consts.bottomNavBarElevation,
      selectedLabelStyle:
          TextStyle(fontSize: FontSize.tiny, fontWeight: FontWeights.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: FontSize.tiny, fontWeight: FontWeights.medium),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(createMaterialColor(colorScheme.primary)),
        minimumSize: btnSize,
        maximumSize: btnSize,
        shape: btnRadius,
        foregroundColor: WidgetStateProperty.all(
          createMaterialColor(colorScheme.tertiary),
        ),
        overlayColor: WidgetStateProperty.all(
          createMaterialColor(colorScheme.tertiary).withOpacity(0.1),
        ),
        textStyle: Consts.btnTextStyle,
      ),
    ),

    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          BorderSide(
            color: createMaterialColor(colorScheme.primary),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          createMaterialColor(colorScheme.tertiary),
        ),
        minimumSize: btnSize,
        maximumSize: btnSize,
        shape: btnRadius,
        foregroundColor: WidgetStateProperty.all(
          createMaterialColor(colorScheme.primary),
        ),
        overlayColor: WidgetStateProperty.all(
          createMaterialColor(colorScheme.primary).withOpacity(0.1),
        ),
        textStyle: Consts.btnTextStyle,
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: Colours.grey_300,
      thickness: Consts.borderThin,
      indent: 0,
      endIndent: 0,
    ),

    // Scrollbar Theme
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        Colours.grey_300,
      ), // Customize the thumb color
      trackColor: WidgetStateProperty.all(
        Colours.grey_100,
      ), // Customize the track color
      radius: const Radius.circular(Consts.radius),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      surfaceTintColor: colorScheme.tertiary,
      shadowColor: Colours.grey_100,
      titleTextStyle: Consts.dialogTitleTextStyle,
      contentTextStyle: Consts.dialogContentTextStyle,
      elevation: Consts.elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Consts.radius)),
      ),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      modalBarrierColor: Colors.transparent,
      backgroundColor: Colours.white_0,
      modalBackgroundColor: Colors.transparent,
    ),

    cardTheme: CardTheme(
      color: Colours.white_0,
      surfaceTintColor: Colours.white_0,
      shadowColor: Colours.grey_100,
      elevation: Consts.elevation,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(Consts.globalContentPaddingS),
      fillColor: Colors.transparent,
      hintStyle: TextStyle(
        fontWeight: FontWeights.medium,
        fontSize: FontSize.medium,
        color: Colours.grey_300,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeights.medium,
        fontSize: FontSize.large,
        color: Colours.magenta,
      ),
      errorStyle: TextStyle(
        fontWeight: FontWeights.medium,
        fontSize: FontSize.medium,
        color: Colours.red,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.grey_300),
        borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.magenta),
        borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.red),
        borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.magenta),
        borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
      ),
    ),
  );
  return themeData;
}

ColorScheme _getColorScheme(Brightness brightness) {
  final lightColorScheme = ColorScheme.light(
    primary: Colours.magenta,
    secondary: Colours.grey_700,
    tertiary: Colours.white_0,
    surface: Colours.white_0,
    error: Colours.red_255,
    outline: Colours.grey_300,
  );
  return lightColorScheme;
}
