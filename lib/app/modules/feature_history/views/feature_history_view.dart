import 'package:business_dir/app/widgets/r_featured_container.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feature_history_controller.dart';

class FeatureHistoryView extends GetView<FeatureHistoryController> {
  const FeatureHistoryView({super.key});
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
          "Feature history",
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.fetchMyFeatures();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const RLoading();
          }
          if (controller.featureds.value.isEmpty) {
            return const RNotFound(label: "No feature request history");
          }
          return RefreshIndicator(
            onRefresh: () => Future.sync(() => controller.fetchMyFeatures()),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: controller.featureds.value.length,
              itemBuilder: (context, index) {
                final featured = controller.featureds.value[index];
                return RFeaturedContainer(
                  featured: featured,
                  userRole: "business_owner",
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: Get.height * 0.02),
            ),
          );
        },
      ),
    );
  }
}
