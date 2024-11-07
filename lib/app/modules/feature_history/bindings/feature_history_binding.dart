import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:get/get.dart';

import '../controllers/feature_history_controller.dart';

class FeatureHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatureHistoryController>(
      () => FeatureHistoryController(),
    );
    Get.lazyPut<FeaturedProvider>(
      () => FeaturedProvider(),
    );
  }
}
