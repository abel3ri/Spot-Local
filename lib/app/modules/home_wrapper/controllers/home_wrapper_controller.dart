import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class HomeWrapperController extends GetxController {
  Rx<int> index = 0.obs;

  void onPageChanged(int i) {
    if (i != 1 && Get.focusScope!.hasFocus) {
      Get.focusScope!.unfocus();
      Get.find<SearchController>().searchResults.value = [];
      Get.find<SearchController>().searchInputController.text = "";
    }
    index.value = i;
  }
}
