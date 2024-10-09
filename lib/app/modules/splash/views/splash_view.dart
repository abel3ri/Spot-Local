import 'package:business_dir/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: Get.find<AuthProvider>().secureStorage.read(key: 'jwtToken'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            Future.delayed(Duration.zero, () {
              Get.offAllNamed('/get-started');
            });
          } else {
            Future.delayed(Duration.zero, () {
              Get.offAllNamed('/home-wrapper');
            });
          }
          return SizedBox();
        },
      ),
    );
  }
}
