import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/city_provider.dart';
import 'package:business_dir/app/modules/create_business/controllers/create_business_controller.dart';
import 'package:business_dir/app/modules/image_picker/controllers/image_picker_controller.dart';
import 'package:get/get.dart';

class CreateBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBusinessController());
    Get.lazyPut(() => ImagePickerController());
    Get.lazyPut(() => CityProvider());
    Get.lazyPut(() => BusinessProvider());
  }
}
