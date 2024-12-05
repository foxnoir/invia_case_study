import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';

class Consts {
  static const double navIconSize = 25;
  static const double acticveNavIconSize = 35;
}

class AppColor {
  static Color white_0 = HexColor.fromHex('#FFFFFF');
  static Color black_0 = HexColor.fromHex('#000000');
  static Color dark_blue = HexColor.fromHex('#002873');
  static Color light_green = HexColor.fromHex('#85BC39');
  static Color orange = HexColor.fromHex('#FF8F16');
  static Color dark_grey = HexColor.fromHex('#595959');
  static Color grey = HexColor.fromHex('#222222');
  static Color light_grey = HexColor.fromHex('#E9E9E9');
  static Color error = HexColor.fromHex('#E60000');
}

class AppFont {
  static const String fontFamily = 'Open Sans';
}

class AppFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class AppFontSize {
  // bottom nav
  static const double s12 = 12;
  // error banner
  static const double s14 = 14;
  // button
  static const double s16 = 16;
  // hotels
  static const double s17 = 17;
  // hotel count
  static const double s19 = 19;
  static const double xLarge = 21;
}

class SvgIcon {
  static const String account = 'assets/icons/account.svg';
  static const String favorite = 'assets/icons/favorite.svg';
  static const String favoriteFilled = 'assets/icons/favorite_filled.svg';
  static const String overview = 'assets/icons/overview.svg';
  static const String hotel = 'assets/icons/hotel.svg';
}

class AppImg {
  static const String sadPalm = 'assets/img/sad_palm.png';
  static const String placeholder = 'assets/img/placeholder.png';
  static const String noFavorites = 'assets/img/no_favorites.png';
}
