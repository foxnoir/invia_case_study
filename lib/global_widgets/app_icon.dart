import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invia_case_study/core/theme/consts.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    required this.assetPath,
    required this.color,
    this.iconSize = Consts.navIconSize,
    super.key,
  });
  final String assetPath;
  final Color color;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
