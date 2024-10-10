import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/category/controllers/category_controller.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_info.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Get.arguments['name']} - Businesses',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
          ),
        ),
        actions: [
          Obx(
            () => PopupMenuButton(
              position: PopupMenuPosition.under,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: Icon(Icons.tune_rounded),
              initialValue: controller.sortBy.value,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "name_asc",
                  child: Text("Name - Asc"),
                ),
                PopupMenuItem(
                  value: "name_dec",
                  child: Text("Name - Dec"),
                ),
                PopupMenuItem(
                  value: "rating",
                  child: Text("Rating"),
                ),
              ],
              onSelected: controller.sortBusinesses,
              enabled: controller.businesses.value.isEmpty ? false : true,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Obx(
            () {
              if (controller.isLoading.value ||
                  Get.find<LocationController>().isLoading.value) {
                return RLinearIndicator();
              }
              return SizedBox();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Obx(() {
          if (controller.businesses.value.isEmpty &&
              controller.isLoading.isFalse) {
            return Center(
              child: RInfo(
                message: "No Businesses in this Category!",
                imagePath: "assets/utils/not_found.svg",
              ),
            );
          }
          return MasonryGridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.businesses.value.length,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final business = controller.businesses.value[index];
              return RBusinessContainer(
                tag: "s${business.name}",
                business: business,
              );
            },
          );
        }),
      ),
    );
  }
}
