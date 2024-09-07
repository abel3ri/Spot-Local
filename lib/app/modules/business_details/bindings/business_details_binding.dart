import 'package:get/get.dart';

import '../controllers/business_details_controller.dart';

class BusinessDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessDetailsController>(
      () => BusinessDetailsController(),
    );
  }
}
