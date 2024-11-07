import 'package:business_dir/app/modules/home/controllers/filter_controller.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class FilteredBusinessView extends GetView<FilterController> {
  const FilteredBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "filterResults".tr,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: controller.businesses.value.isNotEmpty
          ? MasonryGridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: controller.businesses.value.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                final business = controller.businesses.value[index];
                return RBusinessContainer(business: business);
              },
            )
          : RNotFound(label: "noBusinessFound".tr),
    );
  }
}
