import 'package:flutter/material.dart';

class Colours {
  // basics
  static Color white_0 = HexColor.fromHex('#FFFFFF');
  static Color black_0 = HexColor.fromHex('#000000');

  // grey
  static Color grey_100 = HexColor.fromHex('#f5f5f5');
  static Color grey_200 = HexColor.fromHex('#e7e7e7');
  static Color grey_300 = HexColor.fromHex('#cfcfcf');
  static Color grey_400 = HexColor.fromHex('#949494');
  static Color grey_500 = HexColor.fromHex('#828282');
  static Color grey_600 = HexColor.fromHex('#5e5957');
  static Color grey_700 = HexColor.fromHex('#474747');

  // brown
  static Color brown_100 = HexColor.fromHex('#dbd7cb');
  static Color brown_200 = HexColor.fromHex('#9b8c77');

  // feedback
  static Color green = HexColor.fromHex('#219936');
  static Color red = HexColor.fromHex('#f3b79c');

  // error
  static Color red_255 = const Color.fromARGB(255, 176, 0, 32);

  // primary
  static Color magenta = HexColor.fromHex('#b4146e');

  // transparent black
  static Color alphaBlack_50 = const Color.fromARGB(50, 0, 0, 0);
  static Color alphaBlack_100 = const Color.fromARGB(75, 0, 0, 0);
  static Color alphaWhite_255 = const Color.fromARGB(255, 255, 255, 255);
  static Color alphaWhite_225 = const Color.fromARGB(225, 255, 255, 255);
  static Color alphaWhite_200 = const Color.fromARGB(200, 255, 255, 255);
  static Color alphaWhite_150 = const Color.fromARGB(150, 255, 255, 255);
  static Color alphaWhite_50 = const Color.fromARGB(50, 255, 255, 255);
  static Color alphaWhite_0 = const Color.fromARGB(0, 255, 255, 255);

  // transparent yellow
  static Color alphaYellow_150 = const Color.fromARGB(150, 248, 255, 60);
}

// converts a Color into a HexColor
class HexColor extends Color {
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColorString) {
    var hexColor = hexColorString.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color fromHex(String hexColor) {
    return HexColor(hexColor);
  }
}

// converts a Hex color into a MaterialColor
MaterialColor createMaterialColor(Color color) {
  final swatch = <int, Color>{};
  final strengths = <double>[];

  final r = color.red;
  final g = color.green;
  final b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
