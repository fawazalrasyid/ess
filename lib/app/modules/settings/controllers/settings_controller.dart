import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final isNotificationEnabled = false.obs;

  @override
  void onInit() {
    user = auth.currentUser;
    super.onInit();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
