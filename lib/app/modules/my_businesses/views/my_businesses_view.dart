import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:business_dir/app/widgets/r_info.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_businesses_controller.dart';

class MyBusinessesView extends GetView<MyBusinessesController> {
  const MyBusinessesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "My Businesses",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                controller.getMyBusinesses();
              },
              icon: Icon(Icons.refresh, size: 28),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Obx(
            () => controller.isLoading.isTrue ? RLinearIndicator() : SizedBox(),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(child: RCircularIndicator());
        }
        if (controller.businesses.value.isEmpty) {
          return Center(
            child: RInfo(
              message: "No businesses found! Try Refreshing",
              imagePath: "assets/utils/not_found.svg",
            ),
          );
        }

        return ListView.separated(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: controller.businesses.value.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final business = controller.businesses.value[index];
            return RCard(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: "assets/image.png",
                        image: business.logo!,
                        height: 48,
                        width: 48,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/image.png",
                          width: 48,
                          height: 48,
                        ),
                      ),
                      Text(
                        business.name ?? "",
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(business.averageRating?.toStringAsFixed(1) ??
                              "0.0"),
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Get.theme.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    business.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: Get.height * 0.02),
        );
      }),
    );
  }
}
