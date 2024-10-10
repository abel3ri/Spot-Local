import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class HomeWrapperController extends GetxController {
  Rx<int> index = 0.obs;
  late SearchController searchController;

  @override
  void onInit() {
    super.onInit();
    searchController = Get.find<SearchController>();
  }

  void onPageChanged(int i) {
    if (i != 1 && Get.focusScope!.hasFocus) {
      Get.focusScope!.unfocus();
      searchController.searchResults.value = [];
      searchController.searchInputController.text = "";
    }
    index.value = i;
    if (i == 1) {
      searchController.animateSearchLottie(true);
    } else {
      searchController.animateSearchLottie(false);
    }
  }
}
