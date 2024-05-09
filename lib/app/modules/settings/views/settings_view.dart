import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widgets/custom_icons.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({super.key});
  @override
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Pengaturan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1D2E42),
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Akunku',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF444C52),
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(AppValues.padding),
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
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFF9ACD05),
                                  ),
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  controller.user!.photoURL!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.user!.displayName!,
                                  style: const TextStyle(
                                    color: Color(0xFF444C52),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  controller.user!.email!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFB0C4D2),
                                    fontSize: 14,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pengaturan Umum',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF444C52),
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-user.svg',
                            color: AppColors.iconPrimary,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Akun Saya',
                              style: TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-angle-small-up.svg',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE4E9EC), thickness: 1),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const CustomIcon(
                            icon: 'assets/icons/fi-sr-bell.svg',
                            color: AppColors.iconPrimary,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Notifikasi',
                              style: TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            height: 24,
                            child: CupertinoSwitch(
                              value: controller.isNotificationEnabled.value,
                              onChanged: (value) => controller
                                  .isNotificationEnabled.value = value,
                              activeColor: AppColors.colorPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE4E9EC), thickness: 1),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-globe.svg',
                            color: AppColors.iconPrimary,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Bahasa',
                              style: TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Bahasa Indonesia',
                                style: TextStyle(
                                  color: Color(0xFF92A4AF),
                                  fontSize: 14,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 8),
                              CustomIcon(
                                icon: 'assets/icons/fi-sr-angle-small-up.svg',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE4E9EC), thickness: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppValues.margin,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bantuan Lainnya',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF444C52),
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-shield-exclamation.svg',
                            color: AppColors.iconPrimary,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'FAQ',
                              style: TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-angle-small-up.svg',
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(color: Color(0xFFE4E9EC), thickness: 1),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-shield-interrogation.svg',
                            color: AppColors.iconPrimary,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Term Of Service',
                              style: TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 14,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          CustomIcon(
                            icon: 'assets/icons/fi-sr-angle-small-up.svg',
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(color: Color(0xFFE4E9EC), thickness: 1),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: () => controller.logout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF8F8),
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(64, 16, 64, 16),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyBold.logout,
                          color: Color(0xFFEE0000),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Keluar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFEE0000),
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
