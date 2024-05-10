import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final obscurePassword = true.obs;
  final chechkbox = false.obs;
  final isValidForm = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  checkIsValidForm() {
    isValidForm.value = emailCtrl.text.isEmail && passwordCtrl.text.isNotEmpty;
  }

  void login() async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        Get.offAllNamed(Routes.MAIN);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Fluttertoast.showToast(msg: 'Username atau password salah!');
      } else {
        Fluttertoast.showToast(msg: 'Terjadi kesalahan! coba lagi nanti.');
      }
    }

    isLoading.value = false;
  }
}
