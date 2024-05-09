import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => checkUser());
    super.onInit();
  }

  Future checkUser() async {
    if (auth.currentUser == null) {
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.offNamed(Routes.MAIN);
    }
  }
}
