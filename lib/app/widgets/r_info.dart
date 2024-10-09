import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            height: Get.height * 0.1,
            width: Get.width * 0.5,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SvgPicture.asset(imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
