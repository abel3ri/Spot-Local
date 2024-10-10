import 'package:business_dir/app/data/providers/review_provider.dart';
import 'package:get/get.dart';

import '../controllers/review_controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
    Get.lazyPut(() => ReviewProvider());
  }
}
