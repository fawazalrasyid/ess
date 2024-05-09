import 'package:ess/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class CustomIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;

  const CustomIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color = AppColors.iconDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: SvgIcon(
        icon: SvgIconData(icon),
        size: size,
        color: color,
      ),
    );
  }
}
