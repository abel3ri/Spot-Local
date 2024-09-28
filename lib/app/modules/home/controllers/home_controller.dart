import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<BusinessModel>> businesses = Rx<List<BusinessModel>>([]);
  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);
  Rx<bool> isBusinessLoading = false.obs;
  Rx<bool> isCategoryLoading = false.obs;
  Rx<Position?> userPosition = Rx<Position?>(null);

  void setUserPosition(Position position) {
    userPosition.value = position;
  }

  @override
  void onInit() {
    super.onInit();
    Get.find<AuthController>().getUserData();
    getAllCategories();
    getAllBusinesses();
  }

  Future<void> getAllBusinesses() async {
    final businessProvider = Get.find<BusinessProvider>();
    isBusinessLoading(true);
    final res = await businessProvider.findAll();
    isBusinessLoading(false);
    res.fold((l) {
      l.showError();
    }, (List<BusinessModel> r) {
      businesses(r);
    });
  }

  Future<void> getUserPosition() async {
    final locationProvider = Get.find<LocationProvider>();
    isBusinessLoading(true);
    final res = await locationProvider.getCurrentPosition();
    isBusinessLoading(false);
    res.fold((l) {
      l.showError();
    }, (Position r) {
      userPosition(r);
    });
  }

  Future<void> getAllCategories() async {
    final categoryProvider = Get.find<CategoryProvider>();
    isCategoryLoading(true);
    final res = await categoryProvider.findAll();
    isCategoryLoading(false);

    res.fold((l) {
      l.showError();
    }, (List<CategoryModel> r) {
      categories(r);
    });
  }
}
