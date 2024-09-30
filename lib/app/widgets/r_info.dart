import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RInfo extends StatelessWidget {
  const RInfo({
    super.key,
    required this.message,
    required this.imagePath,
  });

  final String message;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Image.asset(imagePath),
        ],
      ),
    );
  }
}
