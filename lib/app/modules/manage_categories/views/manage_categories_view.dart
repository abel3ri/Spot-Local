import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/widgets/category_item.dart';
import 'package:business_dir/app/modules/manage_categories/views/category_form_view.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_delete_alert.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/shimmers/r_circled_button.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../controllers/manage_categories_controller.dart';

class ManageCategoriesView extends GetView<ManageCategoriesController> {
  const ManageCategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
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
          "manageCategories".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          RTextIconButton(
            label: "create".tr,
            onPressed: () {
              controller.categoryNameController.text = "";
              controller.categoryIconController.text = "";
              controller.categoryDescriptionController.text = "";
              Get.to(() => CategoryFormView(), arguments: {
                "type": "create".tr,
              });
            },
            icon: Icons.add,
          ),
        ],
      ),
      body: Obx(
        () {
          if (homeController.isCategoryLoading.isTrue ||
              controller.isLoading.isTrue) {
            return const Center(
              child: RLoading(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => homeController.getAllCategories(),
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: homeController.categories.value.length,
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) {
                final category = homeController.categories.value[index];
                return RCard(
                  child: Column(
                    children: [
                      CategoryItem(
                        onTap: () {},
                        name: category.name,
                        icon: category.icon,
                        color: getCategoryItemColor(index),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RCircledButton.small(
                            icon: Icons.edit,
                            onTap: () {
                              controller.selectedCategory.value = category;
                              controller.categoryNameController.text =
                                  category.name;
                              controller.categoryIconController.text =
                                  category.icon;
                              controller.categoryDescriptionController.text =
                                  category.description;
                              Get.to(() => CategoryFormView(), arguments: {
                                "type": "update".tr,
                                "name": category.name,
                              });
                            },
                          ),
                          RCircledButton.small(
                            icon: Icons.delete,
                            color: Colors.red,
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => RDeleteAlert(
                                  onPressed: () async {
                                    Get.back();
                                    await controller.deleteCategory(
                                      categoryId: category.id,
                                    );
                                  },
                                  itemType: "Category",
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
