import 'package:business_dir/app/data/repositories/admin_panel_repo.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      "ownerRequests".tr,
      "featuredRequests".tr,
      "businesses".tr,
      "users".tr,
      "cities".tr,
      "states".tr,
      "categories".tr
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "adminPanel".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: labels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final label = labels[index];
            return GestureDetector(
              onTap: () {
                if (label == "ownerRequests".tr) {
                  Get.toNamed("/manage-requests");
                } else if (label == "featuredRequests".tr) {
                  Get.toNamed("/manage-feature-requests");
                } else if (label == "businesses".tr) {
                  Get.toNamed("/manage-businesses");
                } else if (label == "users".tr) {
                  Get.toNamed("/manage-users");
                } else if (label == "cities".tr) {
                  Get.toNamed("/manage-cities");
                } else if (label == "states".tr) {
                  Get.toNamed("/manage-states");
                } else if (label == "categories".tr) {
                  Get.toNamed("/manage-categories");
                }
              },
              child: RCard(
                color: colors[index],
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    labels[index],
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
