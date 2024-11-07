import 'package:business_dir/app/modules/home/views/widgets/category_item.dart';
import 'package:business_dir/app/modules/manage_categories/controllers/manage_categories_controller.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_card.dart';
import 'package:business_dir/app/widgets/r_input_field_row.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryFormView extends GetView {
  CategoryFormView({super.key});
  @override
  final ManageCategoriesController controller =
      Get.put(ManageCategoriesController());
  @override
  Widget build(BuildContext context) {
    final String type = Get.arguments?['type'] ?? "No type";
    final String name = Get.arguments?['name'] ?? "No name";
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
          type == 'create'.tr
              ? "${type.capitalize}"
              : '${type.capitalize} - $name',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentTextStyle: context.textTheme.bodyLarge,
                  content: Text(
                    "inTheIconInputField".tr,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("close".tr),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              RInputField(
                controller: controller.categoryNameController,
                label: "categoryName".tr,
                hintText: "enterCategoryName".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormValidator.categoryNameValidator,
              ),
              SizedBox(height: Get.height * 0.02),
              RInputField(
                controller: controller.categoryDescriptionController,
                label: "categoryDescription".tr,
                maxLines: 3,
                hintText: "enterDescriptionOfTheCategory".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormValidator.categoryDescriptionValidator,
              ),
              SizedBox(height: Get.height * 0.01),
              RInputField(
                controller: controller.categoryIconController,
                label: "categoryIconSvgCode".tr,
                maxLines: 5,
                hintText: "enterCategoryIconSVGcode".tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: FormValidator.categoryIconValidtor,
              ),
              SizedBox(height: Get.height * 0.01),
              RCard(
                child: Column(
                  children: [
                    Text("preview".tr),
                    const Divider(
                      thickness: .2,
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Obx(() {
                      if (controller.categoryIconText.value == "" ||
                          controller.categoryNameText.value == "" ||
                          controller.categoryDescriptionText.value == "") {
                        return Text("noPreview".tr);
                      }

                      return Column(
                        children: [
                          CategoryItem(
                            onTap: () {},
                            name: controller.categoryNameText.value,
                            icon: controller.categoryIconText.value,
                          ),
                          Text(
                            controller.categoryDescriptionText.value,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => controller.isLoading.isFalse
                    ? RButton(
                        child: Text("submit".tr),
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (type == 'create'.tr) {
                              await controller.createCategory();
                            } else {
                              await controller.updateCategory();
                            }
                          }
                        },
                      )
                    : const RLoading(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
