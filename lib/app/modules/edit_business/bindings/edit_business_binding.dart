import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/modules/edit_business/controllers/edit_business_controller.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:get/get.dart';

class EditBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditBusinessController());
    Get.lazyPut(() => ImagePickerController());
    Get.lazyPut(() => CityProvider());
    Get.lazyPut(() => BusinessProvider());
  }
}
