import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_item.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PerformanceShimmer extends StatelessWidget {
  const PerformanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: RCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor)
                  : darken(context.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor, 0.2)
                  : darken(context.theme.scaffoldBackgroundColor, 0.2),
              child: RContainerPlaceholder(
                width: Get.width * 0.2,
                height: 48,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor)
                  : darken(context.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor, 0.2)
                  : darken(context.theme.scaffoldBackgroundColor, 0.2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star_rounded,
                    color: Get.isDarkMode
                        ? lighten(context.theme.scaffoldBackgroundColor)
                        : darken(context.theme.scaffoldBackgroundColor),
                    size: 32,
                  );
                }),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor)
                  : darken(context.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(context.theme.scaffoldBackgroundColor, 0.2)
                  : darken(context.theme.scaffoldBackgroundColor, 0.2),
              child: RContainerPlaceholder(
                width: Get.width * 0.3,
                height: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
