import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: const FlutterSecureStorage().read(key: "jwtToken"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: RCircularIndicator(),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            Future.microtask(() => Get.offNamed("get-started"));
          }
          Future.microtask(() => Get.offNamed("home-wrapper"));
          return SizedBox();
        },
      ),
    );
  }
}
