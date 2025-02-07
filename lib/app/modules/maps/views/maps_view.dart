import 'package:ess/app/core/values/app_values.dart';
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
              height: Get.height * 0.5,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: controller.onSnapshotMapCreated,
                    mapType: MapType.satellite,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-7.2575, 112.7521),
                      zoom: 10,
                    ),
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                  GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    mapType: MapType.satellite,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-7.2575, 112.7521),
                      zoom: 10,
                    ),
                    scrollGesturesEnabled: !controller.isAlreadyPredicted.value,
                    rotateGesturesEnabled: !controller.isAlreadyPredicted.value,
                    tiltGesturesEnabled: !controller.isAlreadyPredicted.value,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
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
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: controller.clearSelectedArea,
                      backgroundColor: Colors.white,
                      mini: false,
                      child: const Icon(
                        Icons.replay_sharp,
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
                      const SizedBox(height: 16),
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
                              value: controller.isPredictedResultVisible.value,
                              onChanged: (value) {
                                controller.togglePredict(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
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
                                      controller.isPredictedResultVisible.value
                                          ? controller.isLoading.value
                                              ? 'Memprediksi jumlah carbon...'
                                              : controller
                                                  .selectedAreaCarbonStock.value
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
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
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
                                      controller.isPredictedResultVisible.value
                                          ? controller.isLoading.value
                                              ? 'Memprediksi jumlah biomasa...'
                                              : controller
                                                  .selectedAreaBiomasa.value
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
                          const SizedBox(height: 16),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: controller.isAlreadyPredicted.value
                                  ? () => controller.detailMapping()
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.colorPrimary,
                                elevation: 0,
                                padding:
                                    const EdgeInsets.fromLTRB(64, 16, 64, 16),
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
                                      "Lihat Detail",
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
