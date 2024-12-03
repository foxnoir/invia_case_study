import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DeviceType {
  phone,
  tablet,
}

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({
    required this.tiny,
    required this.phone,
    required this.tablet,
    required this.largeTablet,
    super.key,
  });
  static const String plattformAndroid = 'Android';
  static const String plattformIOS = 'iOS';

  // if the size ist just way to small like this.
  final Widget tiny;

  // The phone mode.
  final Widget phone;

  // the tablet Mode.
  final Widget tablet;

  // The largeTablet mode.
  final Widget largeTablet;

  // The height small limit constant.
  static const int tinyHeightLimit = 100;

  // The width small limit constant.
  static const int tinyLimit = 380;

  // The phone limit constant.
  static const int phoneLimit = 638;

  // The tablet limit constant.
  static const int tabletLimit = 904;

  // The large tablet limit constant.
  static const int largeTabletLimit = 1240;

  // The landscae screeb according to the context.
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  // The tiny height screen limits according to the context.
  static bool isTinyHeightLimit(BuildContext context) =>
      MediaQuery.of(context).size.height < tinyHeightLimit;

  // The tiny width screen limits according to the context.
  static bool isTinyLimit(BuildContext context) =>
      MediaQuery.of(context).size.width < tinyLimit;

  // The phone screen limits according to the context.
  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneLimit &&
      MediaQuery.of(context).size.width >= tinyLimit;

  // The phone screen limits according to the context.
  static bool isTinyPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < tinyLimit;

  // The tablet screen limits according to the context.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= phoneLimit;

  // Checks whether the application is running on an android/ios environment
  static bool get isMobilePlatform => [
        TargetPlatform.android,
        TargetPlatform.iOS,
      ].contains(defaultTargetPlatform);

  static Future<dynamic> landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Future<dynamic> portraitMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < tinyLimit ||
            constraints.maxHeight < tinyHeightLimit) {
          return tiny;
        }
        if (constraints.maxWidth < phoneLimit) {
          return phone;
        }
        if (constraints.maxWidth < tabletLimit) {
          return tablet;
        }
        return largeTablet;
      },
    );
  }
}
