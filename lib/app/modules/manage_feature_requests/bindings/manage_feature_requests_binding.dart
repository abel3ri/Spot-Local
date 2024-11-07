import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_feature_requests_controller.dart';

class ManageFeatureRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageFeatureRequestsController>(
      () => ManageFeatureRequestsController(),
    );
    Get.lazyPut<FeaturedProvider>(
      () => FeaturedProvider(),
    );
  }
}
