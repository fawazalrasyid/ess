import 'package:ess/app/core/values/app_values.dart';
import 'package:ess/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../core/values/app_colors.dart';
import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  MapsView({super.key});
  @override
  final MapsController controller = Get.put(MapsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: Get.height * 0.6,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    mapType: MapType.satellite,
                    initialCameraPosition: const CameraPosition(
                      // target: LatLng(34.052235, -118.243683),
                      target: LatLng(-7.2575, 112.7521),
                      zoom: 10,
                    ),
                    markers: Set<Marker>.of(controller.markers),
                    polygons: Set<Polygon>.of(controller.polygons),
                    onTap: (LatLng location) {
                      final marker = Marker(
                        markerId: MarkerId(location.toString()),
                        position: location,
                      );
                      controller.addMarker(marker);
                    },
                  ),
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.all(AppValues.margin),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: TextField(
                        controller: controller.searchCtrl,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            IconlyLight.search,
                            color: Color(0xFF90A3BF),
                          ),
                          hintText: 'Cari kota disini',
                          hintStyle: TextStyle(
                            color: Color(0xFF90A8BF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                        onSubmitted: (value) {
                          controller.searchAndNavigate(value);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: controller.clearAll,
                      backgroundColor: Colors.white,
                      mini: true,
                      child: const Icon(
                        IconlyLight.delete,
                        color: AppColors.iconPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppValues.padding),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FD),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informasi Carbon',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF444C52),
                                  fontSize: 15,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Dapat melihat jumlah carbon yang dituju',
                                style: TextStyle(
                                  color: Color(0xFF9CAEBA),
                                  fontSize: 10,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                            child: CupertinoSwitch(
                              activeColor: AppColors.colorPrimary,
                              value: controller.isCarbonVisible.value,
                              onChanged: (value) {
                                controller.showCarbonStock(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => controller.isCarbonVisible.value
                            ? Get.toNamed(Routes.DETAIL_MAPPING)
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(16),
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
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                padding: const EdgeInsets.all(10),
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFF6F9FC),
                                  shape: OvalBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFFECF4F8),
                                    ),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/carbon_stock.png',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Carbon Stock',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF1D2E42),
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    controller.selectedAreaCarbonStock.value > 0
                                        ? '${controller.selectedAreaCarbonStock.value} Kg'
                                        : controller.isCarbonVisible.value
                                            ? 'Calculating...'
                                            : '-',
                                    style: const TextStyle(
                                      color: Color(0xFF90A8BF),
                                      fontSize: 14,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
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
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              padding: const EdgeInsets.all(10),
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF6F9FC),
                                shape: OvalBorder(
                                  side: BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Color(0xFFECF4F8),
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/biomasa.png',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Biomasa',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1D2E42),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.selectedAreaBiomasa.value > 0
                                      ? '${controller.selectedAreaBiomasa.value} Kg'
                                      : controller.isCarbonVisible.value
                                          ? 'Calculating...'
                                          : '-',
                                  style: const TextStyle(
                                    color: Color(0xFF90A8BF),
                                    fontSize: 14,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
