import 'package:ess/app/core/values/app_values.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  @override
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/ess_logo.png',
                  width: Get.width * 0.5,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppValues.margin),
                child: const Text(
                  '© Copyright by SYNK Team',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF475D71),
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
