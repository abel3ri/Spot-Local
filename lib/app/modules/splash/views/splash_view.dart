import 'package:business_dir/app/modules/get_started/views/get_started_view.dart';
import 'package:business_dir/app/modules/home_wrapper/views/home_wrapper_view.dart';
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
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const GetStartedView();
          }
          return HomeWrapperView();
        },
      ),
    );
  }
}
