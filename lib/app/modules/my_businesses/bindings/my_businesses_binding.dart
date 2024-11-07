import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:get/get.dart';

import '../controllers/my_businesses_controller.dart';

class MyBusinessesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBusinessesController>(() => MyBusinessesController());
    Get.lazyPut<BusinessProvider>(() => BusinessProvider());
  }
}
