import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widgets/form_item.dart';
import '../../../core/widgets/labeled_checkbox.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.padding,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ess_logo.png',
                      width: Get.width * 0.5,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        color: Color(0xFF1B1B1B),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masukkan email dan password',
                      style: TextStyle(
                        color: Color(0xFF90A8BF),
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FormItem(
                      controller: controller.emailCtrl,
                      validator: controller.checkIsValidForm,
                      label: "Email",
                      hintLabel: "Masukkan Email",
                      inputType: TextInputType.emailAddress,
                      isRequired: true,
                    ),
                    const SizedBox(height: 20),
                    FormItem(
                      controller: controller.passwordCtrl,
                      validator: controller.checkIsValidForm,
                      label: "Password",
                      hintLabel: "Masukkan Password",
                      inputType: TextInputType.visiblePassword,
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabeledCheckbox(
                          label: "Ingat Saya",
                          value: controller.chechkbox.value,
                          onChanged: (bool newValue) {
                            controller.chechkbox.value = newValue;
                          },
                        ),
                        const Text(
                          "Lupa Password",
                          style: TextStyle(
                            color: Color(0xFF1E4E5D),
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: Get.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: AppValues.margin),
                child: ElevatedButton(
                  onPressed: controller.isValidForm.value
                      ? () => controller.login()
                      : null,
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
                          "Masuk",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.REGISTER),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF90A8BF),
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Daftar sekarang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1E4E5D),
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
