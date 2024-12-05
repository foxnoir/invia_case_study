import 'package:flutter/widgets.dart';

class ScreenSize {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double percentualWidth;
  static late double percentualHeight;
  static late Orientation orientation;
  static late TextScaler textScaler;
  static late bool usePhoneLayout;

  static void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    percentualWidth = screenWidth / 100;
    percentualHeight = screenHeight / 100;
    orientation = MediaQuery.of(context).orientation;
    textScaler = MediaQuery.of(context).textScaler;
    usePhoneLayout = mediaQueryData.size.shortestSide < 600;
  }
}
