import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/search/views/widgets/search_input.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_grid.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SearchInput(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => Get.find<LocationController>().isLoading.isTrue
                ? const RLinearIndicator()
                : const SizedBox(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () {
            if (controller.isLoading.isTrue) {
              return const BusinessShimmerGrid();
            }
            if (controller.searchInputController.value.text.isEmpty &&
                controller.animateSearchLottie.isTrue) {
              return Center(
                child: Lottie.asset(
                  width: Get.width * 0.5,
                  fit: BoxFit.cover,
                  repeat: controller.animateSearchLottie.value,
                  "assets/lotties/search.json",
                ),
              );
            }
            if (controller.searchInputController.value.text.isNotEmpty &&
                controller.searchResults.value.isEmpty) {
              return const RNotFound(label: "No Business Found!");
            }
            return MasonryGridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.searchResults.value.length,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final business = controller.searchResults.value[index];
                return RBusinessContainer(
                  business: business,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
