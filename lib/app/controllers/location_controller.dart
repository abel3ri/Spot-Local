import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationController extends GetxController {
  Rx<Position?> userPosition = Rx<Position?>(null);
  Rx<LatLng?> businessCoords = Rx<LatLng?>(null);
  Rx<String> businessName = Rx<String>("");
  late GeolocatorPlatform geolocator;

  @override
  void onInit() {
    super.onInit();
    geolocator = GeolocatorPlatform.instance;
    Get.lazyPut(() => LocationProvider());
  }

  Future<void> getUserCurrentPosition() async {
    final locationProvider = Get.find<LocationProvider>();
    final res = await locationProvider.getCurrentPosition();
    res.fold((l) {
      l.showError();
    }, (r) {
      userPosition(r);
      Get.toNamed("map");
    });
  }

  void setBusinessInfo({
    required LatLng coords,
    required String name,
  }) {
    businessCoords(coords);
    businessName(name);
  }
}
