import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_item.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RRatingRowShimmer extends StatelessWidget {
  const RRatingRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor)
                    : darken(Get.theme.scaffoldBackgroundColor),
                highlightColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                    : darken(Get.theme.scaffoldBackgroundColor, 0.2),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Get.isDarkMode
                      ? lighten(Get.theme.scaffoldBackgroundColor)
                      : darken(Get.theme.scaffoldBackgroundColor),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Get.isDarkMode
                        ? lighten(Get.theme.scaffoldBackgroundColor)
                        : darken(Get.theme.scaffoldBackgroundColor),
                    highlightColor: Get.isDarkMode
                        ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                        : darken(Get.theme.scaffoldBackgroundColor, 0.2),
                    child: RContainerPlaceholder(
                      width: Get.width * 0.3,
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
                      width: Get.width * 0.2,
                      height: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Shimmer.fromColors(
                baseColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor)
                    : darken(Get.theme.scaffoldBackgroundColor),
                highlightColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                    : darken(Get.theme.scaffoldBackgroundColor, 0.2),
                child: Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Get.isDarkMode
                          ? lighten(Get.theme.scaffoldBackgroundColor)
                          : darken(Get.theme.scaffoldBackgroundColor),
                      size: 20,
                    );
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.02),
          Shimmer.fromColors(
            baseColor: Get.isDarkMode
                ? lighten(Get.theme.scaffoldBackgroundColor)
                : darken(Get.theme.scaffoldBackgroundColor),
            highlightColor: Get.isDarkMode
                ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                : darken(Get.theme.scaffoldBackgroundColor, 0.2),
            child: RContainerPlaceholder(
              width: Get.width * 0.7,
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
              width: Get.width * 0.5,
              height: 12,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Shimmer.fromColors(
                baseColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor)
                    : darken(Get.theme.scaffoldBackgroundColor),
                highlightColor: Get.isDarkMode
                    ? lighten(Get.theme.scaffoldBackgroundColor, 0.2)
                    : darken(Get.theme.scaffoldBackgroundColor, 0.2),
                child: RContainerPlaceholder(
                  width: Get.width * 0.2,
                  height: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
