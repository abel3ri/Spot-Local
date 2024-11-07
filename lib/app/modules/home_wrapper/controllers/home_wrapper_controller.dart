import 'package:business_dir/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class HomeWrapperController extends GetxController {
  Rx<int> index = 0.obs;
  late SearchController searchController;
  late FavoriteController favoriteController;

  @override
  void onInit() {
    super.onInit();
    searchController = Get.find<SearchController>();
    favoriteController = Get.find<FavoriteController>();
  }

  void onPageChanged(int i) {
    if (i != 1) {
      if (Get.focusScope?.hasFocus ?? false) {
        Get.focusScope!.unfocus();
      }

      searchController.searchResults.value = [];
      searchController.searchInputController.text = "";
      searchController.isLoading.value = false;
      searchController.animateSearchLottie.value = false;
    } else {
      searchController.animateSearchLottie.value = true;
    }

    index.value = i;
  }
}
