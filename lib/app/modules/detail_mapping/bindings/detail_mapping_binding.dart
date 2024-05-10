import 'package:get/get.dart';

import '../controllers/detail_mapping_controller.dart';

class DetailMappingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMappingController>(
      () => DetailMappingController(),
    );
  }
}
