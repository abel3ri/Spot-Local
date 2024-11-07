import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RNotFound extends StatelessWidget {
  const RNotFound({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              label,
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Lottie.asset(
              fit: BoxFit.cover,
              width: Get.width * 0.5,
              "assets/lotties/not_found.json",
            ),
          ),
        ],
      ),
    );
  }
}
