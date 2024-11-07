import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RLoading extends StatelessWidget {
  const RLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        width: Get.width * 0.2,
        height: Get.height * 0.1,
        fit: BoxFit.cover,
        "assets/lotties/loading.json",
      ),
    );
  }
}
