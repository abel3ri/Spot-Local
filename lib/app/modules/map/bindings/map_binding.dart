import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<LocationProvider>(() => LocationProvider());
  }
}
