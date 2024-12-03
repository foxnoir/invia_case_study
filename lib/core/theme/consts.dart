import 'dart:ui';

import 'package:invia_case_study/core/theme/theme_helpers.dart';

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

class Font {
  static const String fontFamily = 'Open Sans';
}

class FontWeights {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double tiny = 11;
  static const double small = 12;
  static const double medium = 14;
  static const double large = 16;
  static const double xLarge = 20;
  static const double xxLarge = 22;
}
