import 'package:business_dir/app/modules/category/views/all_category_view.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/widgets/category_item.dart';
import 'package:business_dir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoryItemsGrid extends GetView<HomeController> {
  const CategoryItemsGrid({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    const maxVisibleItems = 7;
    final categories = controller.categories.value;
    final isMoreAvailable = categories.length > maxVisibleItems;

    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isMoreAvailable ? maxVisibleItems + 1 : categories.length,
      crossAxisSpacing: 4,
      mainAxisSpacing: 8,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        if (isMoreAvailable && index == maxVisibleItems) {
          return CategoryItem(
            name: "More",
            icon: null,
            color: Colors.grey,
            onTap: () {
              Get.to(() => const AllCategoryView());
            },
          );
        }

        final category = categories[index];
        return CategoryItem(
          name: category.name,
          icon: category.icon,
          color: getCategoryItemColor(index),
          onTap: () async {
            Get.toNamed(
              "category",
              arguments: {
                "id": category.id,
                "name": category.name,
                "description": category.description,
              },
            );
          },
        );
      },
    );
  }
}
