import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.child,
    this.height = kToolbarHeight,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: backgroundColor ?? AppColors.appBarColor,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        // height: preferredSize.height,
        width: Get.width,
        color: backgroundColor ?? AppColors.appBarColor,
        // alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
