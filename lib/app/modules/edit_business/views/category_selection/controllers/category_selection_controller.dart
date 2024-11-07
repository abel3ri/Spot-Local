import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';

import 'package:business_dir/app/modules/edit_business/controllers/edit_business_controller.dart';
import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);
  late CategoryProvider categoryProvider;
  late EditBusinessController editBusinessController;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryProvider = Get.find<CategoryProvider>();
    editBusinessController = Get.find<EditBusinessController>();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    isLoading(true);
    final res = await categoryProvider.findAll();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      categories.value = r;
    });
  }

  void toggleChip(bool isSelected, int index) {
    if (isSelected) {
      if (!editBusinessController.selectedCategories.value
          .any((el) => el.id == categories.value[index])) {
        editBusinessController.selectedCategories.value
            .remove(categories.value[index]);
      }
    } else {
      if (!editBusinessController.selectedCategories.value
          .any((el) => el.id == categories.value[index])) {
        editBusinessController.selectedCategories.value
            .add(categories.value[index]);
      }
    }
    editBusinessController.selectedCategories.refresh();
  }
}
