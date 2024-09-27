import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<BusinessModel>> businesses = Rx<List<BusinessModel>>([]);
  Rx<bool> isLoading = false.obs;
  Rx<Position?> userPosition = Rx<Position?>(null);

  void setUserPosition(Position position) {
    userPosition.value = position;
  }

  @override
  void onInit() {
    super.onInit();
    Get.find<AuthController>().getUserData();
    getAllBusinesses();
  }

  Future<void> getAllBusinesses() async {
    final businessProvider = Get.find<BusinessProvider>();
    isLoading(true);
    final res = await businessProvider.findAll();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (List<BusinessModel> r) {
      businesses(r);
    });
  }

  Future<void> getUserPosition() async {
    final locationProvider = Get.find<LocationProvider>();
    isLoading(true);
    final res = await locationProvider.getCurrentPosition();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (Position r) {
      userPosition(r);
    });
  }
}
