import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut(() => ImagePickerController());
  }
}
