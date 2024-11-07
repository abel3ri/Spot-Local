import 'package:business_dir/app/widgets/r_chip.dart';
import 'package:business_dir/app/widgets/shimmers/chip_wrap_shimmer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_selection_controller.dart';

class CategorySelectionView extends GetView<CategorySelectionController> {
  CategorySelectionView({super.key});
  @override
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "selectCategories".tr,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("selectAllategoriesThat".tr),
            SizedBox(height: Get.height * 0.02),
            Obx(
              () {
                if (controller.isLoading.isTrue) {
                  return const ChipWrapShimmer();
                }
                if (controller.categories.value.isEmpty) {
                  return Text("noCategoryFound".tr);
                }
                final categories = controller.categories.value;
                return Wrap(
                  spacing: 4,
                  children: List.generate(
                    categories.length,
                    (index) {
                      bool isSelected = controller
                              .editBusinessController.selectedCategories.value
                              .contains(categories[index]) ||
                          controller
                              .editBusinessController.selectedCategories.value
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
