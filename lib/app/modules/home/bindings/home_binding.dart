import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BusinessProvider());
    Get.lazyPut(() => LocationProvider());
  }
}
