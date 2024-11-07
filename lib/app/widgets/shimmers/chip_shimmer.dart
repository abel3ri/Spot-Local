import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ChipShimmer extends StatelessWidget {
  const ChipShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode
          ? lighten(context.theme.scaffoldBackgroundColor)
          : darken(context.theme.scaffoldBackgroundColor),
      highlightColor: Get.isDarkMode
          ? lighten(context.theme.scaffoldBackgroundColor, 0.2)
          : darken(context.theme.scaffoldBackgroundColor, 0.2),
      child: Container(
        width: 72,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? lighten(context.theme.scaffoldBackgroundColor)
              : darken(context.theme.scaffoldBackgroundColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: SizedBox(
            height: 24,
            child: Placeholder(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
