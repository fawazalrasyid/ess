import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widgets/form_item.dart';
import '../../../core/widgets/labeled_checkbox.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                controller.currentRegisterStep.value.isEqual(1)
                    ? buildRegisterViewStep1()
                    : buildRegisterViewStep2(),
                const SizedBox(height: 24),
                Container(
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: AppValues.margin),
                  child: ElevatedButton(
                    onPressed: controller.isValidForm.value
                        ? () => controller.currentRegisterStep.value.isEqual(1)
                            ? controller.nextStep()
                            : controller.register()
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
                        : Text(
                            controller.currentRegisterStep.value.isEqual(1)
                                ? "Selanjutanya"
                                : "Daftar Sekarang",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.LOGIN),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF90A8BF),
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Masuk sekarang",
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
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildRegisterViewStep1() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.padding,
      ),
      child: Column(
        children: [
          const Text(
            'Registrasi Akun',
            style: TextStyle(
              color: Color(0xFF1B1B1B),
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Isikan data pribadi anda terlebih dahulu',
            style: TextStyle(
              color: Color(0xFF90A8BF),
              fontSize: 14,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          FormItem(
            controller: controller.nameCtrl,
            validator: controller.checkIsValidForm,
            label: "Nama",
            hintLabel: "Masukkan Nama ",
            inputType: TextInputType.name,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          FormItem(
            controller: controller.addressCtrl,
            validator: controller.checkIsValidForm,
            label: "Alamat",
            hintLabel: "Masukkan Alamat ",
            inputType: TextInputType.streetAddress,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          FormItem(
            controller: controller.phoneNumberCtrl,
            validator: controller.checkIsValidForm,
            label: "Nomor Handphone",
            hintLabel: "Masukkan Nomor Handphone ",
            inputType: TextInputType.phone,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          FormItem(
            controller: controller.emailCtrl,
            validator: controller.checkIsValidForm,
            label: "Email",
            hintLabel: "Masukkan Email",
            inputType: TextInputType.emailAddress,
            isRequired: true,
          ),
        ],
      ),
    );
  }

  Container buildRegisterViewStep2() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.padding,
      ),
      child: Column(
        children: [
          const Text(
            'Registrasi Akun',
            style: TextStyle(
              color: Color(0xFF1B1B1B),
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Isikan data perusahaan anda terlebih dahulu',
            style: TextStyle(
              color: Color(0xFF90A8BF),
              fontSize: 14,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          FormItem(
            controller: controller.instanceNameCtrl,
            validator: controller.checkIsValidForm,
            label: "Nama Instansi",
            hintLabel: "Masukkan Nama Instansi",
            inputType: TextInputType.name,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          FormItem(
            controller: controller.instanceAddressCtrl,
            validator: controller.checkIsValidForm,
            label: "Alamat Instansi",
            hintLabel: "Masukkan Alamat Instansi",
            inputType: TextInputType.streetAddress,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          FormItem(
            controller: controller.instanceEmailCtrl,
            validator: controller.checkIsValidForm,
            label: "Email Instansi",
            hintLabel: "Masukkan Email Instansi",
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
          const SizedBox(height: 20),
          FormItem(
            controller: controller.confirmPasswordCtrl,
            validator: controller.checkIsValidForm,
            label: "Konfirmasi Password",
            hintLabel: "Masukkan Password",
            inputType: TextInputType.visiblePassword,
            isRequired: true,
          ),
          const SizedBox(height: 8),
          LabeledCheckbox(
            label: "Saya menyetujui Syarat & Ketentuan",
            value: controller.chechkbox.value,
            onChanged: (bool newValue) {
              controller.chechkbox.value = newValue;
              controller.checkIsValidForm();
            },
          ),
        ],
      ),
    );
  }
}
