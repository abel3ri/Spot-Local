import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/map/controllers/map_controller.dart';
import 'package:business_dir/app/modules/map/views/widgets/map_zoom_button.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as FlutterMap;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterMap.MapController mapController = FlutterMap.MapController();
    final locationController = Get.find<LocationController>();
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: SizedBox(
              child: Obx(
                () => FlutterMap.FlutterMap(
                  mapController: mapController,
                  options: FlutterMap.MapOptions(
                    backgroundColor: context.theme.scaffoldBackgroundColor,
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
                            color: context.theme.colorScheme.primary,
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
                            color: context.theme.colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: context.theme.scaffoldBackgroundColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MapZoomButton(
                              // mapPageController: mapPageController,
                              mapController: mapController,
                              icon: Icons.add,
                            ),
                            const SizedBox(height: 4),
                            MapZoomButton(
                              mapController: mapController,
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
                color: context.theme.scaffoldBackgroundColor.withOpacity(.8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(4, 4),
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
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      locationController.businessName.value,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: controller.isLoading.value
                          ? RCircularIndicator(
                              color: context.theme.primaryColor,
                            )
                          : Text(
                              "~ ${controller.distance.value.toStringAsFixed(2)} Kms",
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.colorScheme.primary,
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
