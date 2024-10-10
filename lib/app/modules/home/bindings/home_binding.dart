import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BusinessProvider());
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => CategoryProvider());
  }
}
