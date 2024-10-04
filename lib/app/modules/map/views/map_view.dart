import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/map/controllers/map_controller.dart';
import 'package:business_dir/app/modules/map/views/widgets/map_zoom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as FlutterMap;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapView extends GetView<MapController> {
  MapView({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterMap.MapController _mapController = FlutterMap.MapController();
    final locationController = Get.find<LocationController>();
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: SizedBox(
              child: Obx(
                () => FlutterMap.FlutterMap(
                  mapController: _mapController,
                  options: FlutterMap.MapOptions(
                    backgroundColor: Get.theme.scaffoldBackgroundColor,
                    // maxZoom: 14,
                    onPositionChanged: (camera, hasGesture) {
                      controller.updateCenter(camera.center);
                    },
                    initialZoom: controller.currentZoom.value,
                    initialCenter: controller.currentCenter.value!,
                  ),
                  children: [
                    FlutterMap.TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    if (!locationController.isLoading.value &&
                        controller.routePoints.value != null)
                      FlutterMap.PolylineLayer(
                        polylines: [
                          FlutterMap.Polyline(
                            points: controller.routePoints.value!,
                            color: Get.theme.colorScheme.primary,
                            strokeWidth: 6,
                          )
                        ],
                      ),
                    FlutterMap.MarkerLayer(
                      markers: [
                        FlutterMap.Marker(
                          point: LatLng(
                            controller.userPosition.value!.latitude,
                            controller.userPosition.value!.longitude,
                          ),
                          child: Icon(
                            Icons.my_location,
                            color: Colors.blue.shade800,
                            size: 32,
                          ),
                        ),
                        FlutterMap.Marker(
                          point: LatLng(
                            controller.businessCoords.latitude,
                            controller.businessCoords.longitude,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Get.theme.colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MapZoomButton(
                              // mapPageController: mapPageController,
                              mapController: _mapController,
                              icon: Icons.add,
                            ),
                            SizedBox(height: 4),
                            MapZoomButton(
                              mapController: _mapController,
                              icon: Icons.remove,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor.withOpacity(.8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 4,
                  ),
                ],
              ),
              width: Get.width * 0.9,
              height: Get.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      locationController.businessName.value,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        "~ ${controller.distance.value.toStringAsFixed(2)} Kms",
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
