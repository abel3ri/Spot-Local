import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final Rx<bool> isLoading = false.obs;
  final Rx<List<BusinessModel>> businesses = Rx<List<BusinessModel>>([]);
  late CategoryProvider categoryProvider;
  Rx<String> sortBy = Rx<String>("name_asc");

  @override
  void onInit() {
    super.onInit();
    categoryProvider = Get.find<CategoryProvider>();
    getAllBusinessOfCategory(id: Get.arguments['id']);
  }

  Future<void> getAllBusinessOfCategory({required String id}) async {
    isLoading(true);
    final res = await categoryProvider.findAllBusinessOfCategory(id: id);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (List<BusinessModel> r) {
      businesses.value = r;
    });
  }

  void sortBusinesses(String value) {
    sortBy.value = value;

    if (value == "name_asc") {
      businesses.value.sort(
        (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
      );
    } else if (value == "name_dec") {
      businesses.value.sort(
        (a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()),
      );
    } else if (value == 'rating') {
      businesses.value.sort(
          (a, b) => ((b.averageRating ?? 0) - (a.averageRating ?? 0)).toInt());
    }

    businesses.refresh();
  }
}
