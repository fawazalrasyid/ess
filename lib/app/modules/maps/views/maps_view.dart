import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  MapsView({super.key});
  @override
  final MapsController controller = Get.put(MapsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MapsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
