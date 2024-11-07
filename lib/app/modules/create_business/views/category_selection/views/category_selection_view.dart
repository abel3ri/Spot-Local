import 'package:business_dir/app/widgets/r_chip.dart';
import 'package:business_dir/app/widgets/shimmers/chip_wrap_shimmer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_selection_controller.dart';

class CategorySelectionView extends GetView {
  CategorySelectionView({super.key});
  final CategorySelectionController controller =
      Get.put(CategorySelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "Select  Categories",
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.getAllCategories();
            },
            icon: Icon(
              Icons.refresh_rounded,
              size: 28,
              color: context.theme.primaryColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select all categories that applies to your business"),
            SizedBox(height: Get.height * 0.02),
            Obx(
              () {
                if (controller.isLoading.isTrue) {
                  return ChipWrapShimmer();
                }
                if (controller.categories.value.isEmpty) {
                  return Text("No categories found. Try refreshing");
                }
                final categories = controller.categories.value;
                return Wrap(
                  spacing: 4,
                  children: List.generate(
                    categories.length,
                    (index) {
                      bool isSelected = controller
                              .createBusinessController.selectedCategories.value
                              .contains(categories[index]) ||
                          controller
                              .createBusinessController.selectedCategories.value
                              .any((el) => el.id == categories[index].id);

                      return RChip(
                        onTap: () {
                          controller.toggleChip(isSelected, index);
                        },
                        label: categories[index].name,
                        color:
                            isSelected ? Get.theme.primaryColor : Colors.grey,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
