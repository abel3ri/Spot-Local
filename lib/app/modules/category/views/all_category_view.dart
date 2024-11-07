import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/widgets/category_item.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class AllCategoryView extends GetView<HomeController> {
  const AllCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          "All categories".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: MasonryGridView.builder(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: controller.categories.value.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            final category = controller.categories.value[index];
            return CategoryItem(
              onTap: () {
                Get.toNamed(
                  "category",
                  arguments: {
                    "id": category.id,
                    "name": category.name,
                    "description": category.description,
                  },
                );
              },
              color: getCategoryItemColor(index),
              name: category.name,
              icon: category.icon,
            );
          }),
    );
  }
}
