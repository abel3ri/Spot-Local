import 'package:business_dir/app/modules/edit_business/controllers/edit_business_controller.dart';
import 'package:business_dir/app/widgets/r_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RCityDropdown extends StatelessWidget {
  RCityDropdown({
    super.key,
  });
  final controller = Get.find<EditBusinessController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RCircularIndicator(color: Get.theme.primaryColor),
        );
      }
      if (controller.cities.value.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            onPressed: () async {
              await controller.getAllCities();
            },
            icon: Icon(Icons.refresh, color: context.theme.primaryColor),
          ),
        );
      }
      final cities = controller.cities.value;
      return DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        underline: const SizedBox.shrink(),
        elevation: 0,
        borderRadius: BorderRadius.circular(8),
        alignment: Alignment.centerRight,
        items: List.generate(
          cities.length,
          (index) => DropdownMenuItem(
            value: cities[index].name?.toLowerCase() ?? "",
            child: Text('${cities[index].name}'),
          ),
        ),
        onChanged: (value) {
          controller.selectedCity.value =
              cities.firstWhere((city) => city.name?.toLowerCase() == value);
        },
        value: controller.selectedCity.value?.name?.toLowerCase(),
      );
    });
  }
}
