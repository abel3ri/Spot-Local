import 'dart:async';

import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapController extends GetxController {
  Rx<Position?> userPosition = Rx<Position?>(null);
  Rx<bool> isLoading = true.obs;
  late StreamSubscription<Position> locationUpdateStream;
  Rx<double> currentZoom = 12.0.obs;
  Rx<LatLng?> currentCenter = Rx<LatLng?>(null);
  late LatLng businessCoords;
  late GeolocatorPlatform geolocator;
  Timer? _cameraPositionUpdateFnTimer;
  Rx<List<LatLng>?> routePoints = Rx<List<LatLng>?>(null);
  Rx<double> distance = Rx<double>(0);

  @override
  void onInit() {
    super.onInit();
    final locationController = Get.find<LocationController>();
    final locationProvider = Get.find<LocationProvider>();
    geolocator = locationController.geolocator;
    userPosition.value = locationController.userPosition.value;
    businessCoords = locationController.businessCoords.value!;
    currentCenter.value = LatLng(
      userPosition.value!.latitude,
      userPosition.value!.longitude,
    );
    locationUpdateStream = geolocator
        .getPositionStream(
      locationSettings: const LocationSettings(
        distanceFilter: 3,
        accuracy: LocationAccuracy.best,
      ),
    )
        .listen((position) async {
      try {
        userPosition.value = position;
        currentCenter.value = LatLng(position.latitude, position.longitude);
        final res = await locationProvider.getRoutePoints(
          userCoords: currentCenter.value!,
          businessCoords: businessCoords,
        );
        res.fold((l) {
          l.showError();
        }, (r) {
          routePoints.value = r['routePoints'];
          distance.value = r['distance'] / 1000;
        });
      } catch (e) {
      } finally {
        isLoading.value = false;
      }
    });
  }

  void toggleIsLoading() {
    isLoading.value = !isLoading.value;
  }

  void increaseCurrentZoom() {
    currentZoom.value += 1;
  }

  void decreaseCurrentZoom() {
    currentZoom.value -= 1;
  }

  void updateCenter(LatLng newCenter) {
    if (_cameraPositionUpdateFnTimer?.isActive ?? false) {
      _cameraPositionUpdateFnTimer!.cancel();
    }
    _cameraPositionUpdateFnTimer = Timer(const Duration(milliseconds: 300), () {
      if (kDebugMode) {
        // print(newCenter);
      }
      currentCenter.value = newCenter;
    });
  }

  @override
  void onClose() {
    super.onClose();
    locationUpdateStream.cancel().then((_) {
      print("location updates stopped.");
    });
  }
}
