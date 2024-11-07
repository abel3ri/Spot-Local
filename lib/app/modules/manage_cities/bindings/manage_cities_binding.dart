import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_cities_controller.dart';

class ManageCitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageCitiesController>(
      () => ManageCitiesController(),
    );
    Get.lazyPut<CityProvider>(
      () => CityProvider(),
    );
  }
}
