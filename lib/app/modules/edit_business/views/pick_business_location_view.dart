import 'package:business_dir/app/modules/edit_business/controllers/edit_business_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PickBusinessLocationView extends GetView {
  PickBusinessLocationView({super.key});
  @override
  final controller = Get.find<EditBusinessController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            width: Get.width,
            height: Get.height,
            child: Obx(
              () => FlutterMap(
                options: MapOptions(
                  onTap: (tapPosition, point) async {
                    controller.setBusinessCoords(point);
                    await controller.getAddressFromLatLng();
                  },
                  initialCenter:
                      const LatLng(9.019559612088434, 38.75138142503363),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  if (controller.businessLatLng.value != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            controller.businessLatLng.value!.latitude,
                            controller.businessLatLng.value!.longitude,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Get.theme.colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                ],
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
                    onPressed: () async {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Pick Business Location",
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => TextButton(
                        onPressed: controller.businessLatLng.value != null
                            ? () {
                                Get.back();
                              }
                            : null,
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Done",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
