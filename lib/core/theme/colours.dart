import 'package:flutter/material.dart';

class Colours {
  // basics
  static Color white_0 = HexColor.fromHex('#FFFFFF');
  static Color black_0 = HexColor.fromHex('#000000');
  static Color dark_blue = HexColor.fromHex('#002873');
  static Color light_green = HexColor.fromHex('#85BC39');
  static Color orange = HexColor.fromHex('#FF8F16');
  static Color dark_grey = HexColor.fromHex('#595959');
  static Color light_grey = HexColor.fromHex('#E9E9E9');

  // error
  static Color error = const Color.fromARGB(255, 176, 0, 32);
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
