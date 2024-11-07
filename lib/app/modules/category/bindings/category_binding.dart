import 'package:business_dir/app/data/providers/favorite_provider.dart';
import 'package:business_dir/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut(() => FavoriteController());
    Get.lazyPut(() => FavoriteProvider());
  }
}
