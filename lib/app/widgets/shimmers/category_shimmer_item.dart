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
              ? lighten(context.theme.scaffoldBackgroundColor)
              : darken(context.theme.scaffoldBackgroundColor),
          child: Shimmer.fromColors(
            baseColor: Get.isDarkMode
                ? context.theme.scaffoldBackgroundColor
                : context.theme.scaffoldBackgroundColor,
            highlightColor: Get.isDarkMode
                ? lighten(context.theme.scaffoldBackgroundColor, 0.2)
                : darken(context.theme.scaffoldBackgroundColor, 0.2),
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
              ? lighten(context.theme.scaffoldBackgroundColor, 0.25)
              : darken(context.theme.scaffoldBackgroundColor, 0.25),
          child: const Text(
            "Name",
          ),
        ),
      ],
    );
  }
}
