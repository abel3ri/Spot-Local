import 'package:business_dir/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:business_dir/app/modules/profile/controllers/profile_controller.dart';
import 'package:business_dir/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_wrapper_controller.dart';

class HomeWrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeWrapperController>(() => HomeWrapperController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
