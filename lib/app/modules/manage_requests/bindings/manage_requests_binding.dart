import 'package:business_dir/app/data/providers/business_owner_request_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_requests_controller.dart';

class ManageRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageRequestsController>(
      () => ManageRequestsController(),
    );
    Get.lazyPut<BusinessOwnerRequestProvider>(
      () => BusinessOwnerRequestProvider(),
    );
  }
}
