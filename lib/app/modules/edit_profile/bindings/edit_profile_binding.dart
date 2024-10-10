import 'package:business_dir/app/data/providers/user_provider.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    Get.lazyPut<UserProvider>(() => UserProvider());
  }
}
