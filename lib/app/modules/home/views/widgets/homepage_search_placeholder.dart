import 'package:business_dir/app/modules/home_wrapper/controllers/home_wrapper_controller.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageSearchPlaceHolder extends StatelessWidget {
  const HomePageSearchPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<HomeWrapperController>().onPageChanged(1);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? lighten(context.theme.scaffoldBackgroundColor, 0.15)
                : darken(context.theme.scaffoldBackgroundColor, 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: Get.width * 0.9,
            height: 48,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "searchBusiness".tr,
                  style: context.textTheme.bodyLarge,
                ),
                const Icon(
                  Icons.search,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
