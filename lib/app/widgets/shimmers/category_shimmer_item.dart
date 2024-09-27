import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerItem extends StatelessWidget {
  const CategoryShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Get.isDarkMode
              ? lighten(Get.theme.scaffoldBackgroundColor)
              : darken(Get.theme.scaffoldBackgroundColor),
          child: Shimmer.fromColors(
            baseColor: Get.isDarkMode
                ? Get.theme.scaffoldBackgroundColor
                : Get.theme.scaffoldBackgroundColor,
            highlightColor: Get.isDarkMode
                ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                : darken(Get.theme.scaffoldBackgroundColor, 0.2),
            child: const Icon(
              Icons.business,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Shimmer.fromColors(
          baseColor: Get.textTheme.bodyMedium!.color!,
          highlightColor: Get.isDarkMode
              ? lighten(Get.theme.scaffoldBackgroundColor, 0.25)
              : darken(Get.theme.scaffoldBackgroundColor, 0.25),
          child: const Text(
            "Name",
          ),
        ),
      ],
    );
  }
}
