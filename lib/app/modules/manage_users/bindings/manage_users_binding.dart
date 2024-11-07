import 'package:business_dir/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/manage_users_controller.dart';

class ManageUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageUsersController>(
      () => ManageUsersController(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
  }
}
