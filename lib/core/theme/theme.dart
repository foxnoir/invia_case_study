import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';

ThemeData getLightTheme() {
  return _theme(_getColorScheme(Brightness.light));
}

ThemeData _theme(ColorScheme colorScheme) {
  final themeData = ThemeData(
    fontFamily: Font.fontFamily,
    primaryColor: colorScheme.primary,
    secondaryHeaderColor: colorScheme.secondary,
    disabledColor: Colours.dark_grey,
    scaffoldBackgroundColor: colorScheme.surface,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,

    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: FontSize.large,
        fontWeight: FontWeights.medium,
        color: colorScheme.tertiary,
      ),
    ),
    iconTheme: IconThemeData(color: colorScheme.onSurface),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: colorScheme.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: FontSize.xLarge,
        fontWeight: FontWeights.bold,
        color: colorScheme.onPrimary,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          color: colorScheme.primary,
          size: 35,
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.pink,
          fontSize: FontSize.xLarge,
        ),
        unselectedItemColor: colorScheme.tertiary),

    // BottomNavigationBar Theme
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   elevation: Consts.bottomNavBarElevation,
    //   selectedLabelStyle:
    //       TextStyle(fontSize: FontSize.tiny, fontWeight: FontWeights.bold),
    //   unselectedLabelStyle:
    //       TextStyle(fontSize: FontSize.tiny, fontWeight: FontWeights.medium),
    // ),

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
      color: Colours.light_grey,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    ),

    // Scrollbar Theme
    // scrollbarTheme: ScrollbarThemeData(
    //   thumbColor: WidgetStateProperty.all(
    //     Colours.grey_300,
    //   ), // Customize the thumb color
    //   trackColor: WidgetStateProperty.all(
    //     Colours.grey_100,
    //   ), // Customize the track color
    //   radius: const Radius.circular(Consts.radius),
    // ),

    // Dialog Theme
    // dialogTheme: DialogTheme(
    //   surfaceTintColor: colorScheme.tertiary,
    //   shadowColor: Colours.grey_100,
    //   titleTextStyle: Consts.dialogTitleTextStyle,
    //   contentTextStyle: Consts.dialogContentTextStyle,
    //   elevation: Consts.elevation,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    // ),

    // bottomSheetTheme: BottomSheetThemeData(
    //   modalBarrierColor: Colors.transparent,
    //   backgroundColor: Colours.white_0,
    //   modalBackgroundColor: Colors.transparent,
    // ),

    // cardTheme: CardTheme(
    //   color: Colours.white_0,
    //   surfaceTintColor: Colours.white_0,
    //   shadowColor: Colours.grey_100,
    //   elevation: Consts.elevation,
    // ),

    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(Consts.globalContentPaddingS),
    //   fillColor: Colors.transparent,
    //   hintStyle: TextStyle(
    //     fontWeight: FontWeights.medium,
    //     fontSize: FontSize.medium,
    //     color: Colours.grey_300,
    //   ),
    //   labelStyle: TextStyle(
    //     fontWeight: FontWeights.medium,
    //     fontSize: FontSize.large,
    //     color: Colours.magenta,
    //   ),
    //   errorStyle: TextStyle(
    //     fontWeight: FontWeights.medium,
    //     fontSize: FontSize.medium,
    //     color: Colours.red,
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colours.grey_300),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colours.magenta),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colours.red),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colours.magenta),
    //     borderRadius: const BorderRadius.all(Radius.circular(Consts.radius)),
    //   ),
    // ),
  );
  return themeData;
}

ColorScheme _getColorScheme(Brightness brightness) {
  final lightColorScheme = ColorScheme.light(
    primary: Colours.dark_blue,
    secondary: Colours.orange,
    tertiary: Colours.dark_grey,
    surface: Colours.white_0,
    error: Colours.error,
    outline: Colours.light_grey,
    onPrimary: Colours.white_0,
  );
  return lightColorScheme;
}
