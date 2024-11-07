import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCategoriesController extends GetxController {
  late CategoryProvider categoryProvider;
  late HomeController homeController;
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryIconController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();
  Rx<String> categoryIconText = "".obs;
  Rx<String> categoryNameText = "".obs;
  Rx<String> categoryDescriptionText = "".obs;
  final formKey = GlobalKey<FormState>();
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    categoryProvider = Get.find<CategoryProvider>();
    homeController = Get.find<HomeController>();
    categoryIconController.addListener(() {
      categoryIconText.value = categoryIconController.text;
    });
    categoryNameController.addListener(() {
      categoryNameText.value = categoryNameController.text;
    });
    categoryDescriptionController.addListener(() {
      categoryDescriptionText.value = categoryDescriptionController.text;
    });
    super.onInit();
  }

  Future<void> createCategory() async {
    isLoading(true);
    final res = await categoryProvider.create(categoryData: {
      "name": categoryNameController.text,
      "description": categoryDescriptionController.text,
      "icon": categoryIconController.text,
    });
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) async {
      Get.back();
      await homeController.getAllCategories();
      homeController.refresh();
    });
  }

  Future<void> updateCategory() async {
    isLoading(true);
    final res = await categoryProvider.updateOne(
      categoryId: selectedCategory.value!.id,
      categoryData: {
        "name": categoryNameController.text,
        "description": categoryDescriptionController.text,
        "icon": categoryIconController.text,
      },
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) async {
      Get.back();
      await homeController.getAllCategories();
      homeController.refresh();
    });
  }

  Future<void> deleteCategory({required String categoryId}) async {
    isLoading(true);
    final res = await categoryProvider.deleteOne(
      categoryId: categoryId,
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) async {
      await homeController.getAllCategories();
      homeController.refresh();
    });
  }

  @override
  void onClose() {
    categoryIconController.dispose();
    categoryNameController.dispose();
    categoryDescriptionController.dispose();
    super.onClose();
  }
}
