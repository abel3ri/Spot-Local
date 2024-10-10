import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
