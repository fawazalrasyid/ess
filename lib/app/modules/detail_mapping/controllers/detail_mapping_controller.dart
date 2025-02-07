import 'dart:async';

import 'package:ess/app/core/values/app_colors.dart';
import 'package:ess/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class DetailMappingController extends GetxController {
  final isLoading = false.obs;

  final selectedAreaImage = ''.obs;
  final selectedAreaName = ''.obs;
  final selectedAreaCarbonStock = ''.obs;
  final selectedAreaBiomasa = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  void getArgument() {
    final arguments = Get.arguments;
    selectedAreaImage.value = arguments['image'];
    selectedAreaName.value = arguments['name'];
    selectedAreaCarbonStock.value = arguments['carbonStock'];
    selectedAreaBiomasa.value = arguments['biomasa'];
  }

  void saveData() {
    isLoading.value = true;

    Timer(const Duration(seconds: 2), () async {
      showDialog();
      isLoading.value = false;
      Timer(const Duration(seconds: 2), () async {
        Get.offAllNamed(Routes.MAIN);
      });
    });
  }

  void showDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 10.0,
      backgroundColor: Colors.white,
      title: '',
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: const SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.tick_square,
              size: 64,
              color: AppColors.iconPrimary,
            ),
            SizedBox(height: 16),
            Text(
              'Data berhasil disimpan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF3D3F40),
                fontSize: 16,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
