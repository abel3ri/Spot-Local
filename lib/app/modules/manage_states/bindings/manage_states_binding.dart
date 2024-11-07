import 'package:business_dir/app/data/providers/state_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_states_controller.dart';

class ManageStatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageStatesController>(
      () => ManageStatesController(),
    );
    Get.lazyPut<StateProvider>(
      () => StateProvider(),
    );
  }
}
