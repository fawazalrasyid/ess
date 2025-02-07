import 'dart:io';

import 'package:ess/app/core/values/app_colors.dart';
import 'package:ess/app/core/values/app_values.dart';
import 'package:ess/app/core/widgets/custom_app_bar.dart';
import 'package:ess/app/core/widgets/custom_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_mapping_controller.dart';

class DetailMappingView extends GetView<DetailMappingController> {
  const DetailMappingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.pageBackground,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 20),
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.appBarIconColor,
                    ),
                  ),
                ),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Detail Mapping',
                        style: TextStyle(
                          color: Color(0xFF1D2E42),
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Google Earth Engine',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1D2E42),
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  height: 180,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    child: Image.file(
                      width: Get.width,
                      File(controller.selectedAreaImage.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x99ECF3F6),
                        blurRadius: 15,
                        offset: Offset(0, 15),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF0F8DA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.81),
                              ),
                            ),
                            child: const CustomIcon(
                              icon: 'assets/icons/fi-sr-home-location-alt.svg',
                              color: AppColors.iconPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Lokasi Daerah',
                                  style: TextStyle(
                                    color: Color(0xFF92A4AF),
                                    fontSize: 14,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.selectedAreaName.value,
                                  style: const TextStyle(
                                    color: Color(0xFF1D2E42),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF0F8DA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.81),
                              ),
                            ),
                            child: const CustomIcon(
                              icon: 'assets/icons/fi-sr-life-ring.svg',
                              color: AppColors.iconPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jumlah Carbon',
                                style: TextStyle(
                                  color: Color(0xFF92A4AF),
                                  fontSize: 14,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.selectedAreaCarbonStock.value,
                                style: const TextStyle(
                                  color: Color(0xFF1D2E42),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF0F8DA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.81),
                              ),
                            ),
                            child: const CustomIcon(
                              icon: 'assets/icons/fi-sr-leaf.svg',
                              color: AppColors.iconPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jumlah Biomasa',
                                style: TextStyle(
                                  color: Color(0xFF92A4AF),
                                  fontSize: 14,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.selectedAreaBiomasa.value,
                                style: const TextStyle(
                                  color: Color(0xFF1D2E42),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  child: ElevatedButton(
                    onPressed: () => controller.saveData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(64, 16, 64, 16),
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Simpan Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
