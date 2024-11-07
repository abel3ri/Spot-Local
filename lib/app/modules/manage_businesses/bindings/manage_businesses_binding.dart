import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_businesses_controller.dart';

class ManageBusinessesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageBusinessesController>(
      () => ManageBusinessesController(),
    );
    Get.lazyPut<BusinessProvider>(
      () => BusinessProvider(),
    );
  }
}
