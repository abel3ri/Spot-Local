import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:get/get.dart';

import '../controllers/feature_business_controller.dart';

class FeatureBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatureBusinessController>(
      () => FeatureBusinessController(),
    );
    Get.lazyPut<FeaturedProvider>(
      () => FeaturedProvider(),
    );
  }
}
