import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BusinessShimmerItem extends StatelessWidget {
  const BusinessShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.45,
      height: Get.height * 0.28,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Get.theme.scaffoldBackgroundColor
            : Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
        child: Column(
          children: [
            Center(
              child: Shimmer.fromColors(
                baseColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor)
                    : darken(Get.theme.scaffoldBackgroundColor),
                highlightColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                    : darken(Get.theme.scaffoldBackgroundColor, 0.2),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Get.isDarkMode
                      ? lighten(Get.theme.scaffoldBackgroundColor)
                      : darken(Get.theme.scaffoldBackgroundColor),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor)
                  : darken(Get.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                  : darken(Get.theme.scaffoldBackgroundColor, 0.2),
              child: RContainerPlaceholder(
                width: Get.width * 0.2,
                height: 16,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor)
                  : darken(Get.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                  : darken(Get.theme.scaffoldBackgroundColor, 0.2),
              child: RContainerPlaceholder(
                width: Get.width * 0.4,
                height: 12,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor)
                  : darken(Get.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                  : darken(Get.theme.scaffoldBackgroundColor, 0.2),
              child: RContainerPlaceholder(
                width: Get.width * 0.4,
                height: 12,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Shimmer.fromColors(
              baseColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor)
                  : darken(Get.theme.scaffoldBackgroundColor),
              highlightColor: Get.isDarkMode
                  ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                  : darken(Get.theme.scaffoldBackgroundColor, 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CategoryPlaceholder(),
                  SizedBox(width: Get.width * 0.01),
                  const CategoryPlaceholder(),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Icon(Icons.star_rounded, color: Get.theme.primaryColor),
          ],
        ),
      ),
    );
  }
}

class RContainerPlaceholder extends StatelessWidget {
  const RContainerPlaceholder({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Get.isDarkMode
          ? lighten(Get.theme.scaffoldBackgroundColor, 0.5)
          : darken(Get.theme.scaffoldBackgroundColor, 0.3),
    );
  }
}

class CategoryPlaceholder extends StatelessWidget {
  const CategoryPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Get.isDarkMode
            ? lighten(Get.theme.scaffoldBackgroundColor)
            : darken(Get.theme.scaffoldBackgroundColor),
      ),
    );
  }
}
