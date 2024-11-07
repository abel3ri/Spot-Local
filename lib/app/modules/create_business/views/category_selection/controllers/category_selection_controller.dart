import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:business_dir/app/modules/create_business/controllers/create_business_controller.dart';
import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);
  late CategoryProvider categoryProvider;
  late CreateBusinessController createBusinessController;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryProvider = Get.find<CategoryProvider>();
    createBusinessController = Get.find<CreateBusinessController>();
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
      if (!createBusinessController.selectedCategories.value
          .any((el) => el.id == categories.value[index])) {
        createBusinessController.selectedCategories.value
            .remove(categories.value[index]);
      }
    } else {
      if (!createBusinessController.selectedCategories.value
          .any((el) => el.id == categories.value[index])) {
        createBusinessController.selectedCategories.value
            .add(categories.value[index]);
      }
    }
    createBusinessController.selectedCategories.refresh();
  }
}
