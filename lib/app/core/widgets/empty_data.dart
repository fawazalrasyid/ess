import 'package:flutter/material.dart';

import '../values/app_values.dart';

class EmptyData extends StatelessWidget {
  final String text;
  final double imageSize;
  final double fontSize;
  final Color fontColor;

  const EmptyData({
    required this.text,
    this.imageSize = 180,
    this.fontSize = 20,
    this.fontColor = const Color(0xFF0A0A0A),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppValues.margin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/empty_data.png',
            height: imageSize,
            width: imageSize,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
