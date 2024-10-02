import 'package:business_dir/app/modules/search/views/widgets/search_input.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_info.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_grid.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchInput(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Obx(
          () {
            if (controller.isLoading.isTrue) {
              return BusinessShimmerGrid();
            }

            if (controller.searchInputController.value.text.isEmpty) {
              return Center(
                child: RInfo(
                  message: "Try Searching a Business!",
                  imagePath: "assets/find.png",
                ),
              );
            }

            if (controller.searchInputController.value.text.isNotEmpty &&
                controller.searchResults.value.isEmpty) {
              return RInfo(
                message: "No business found!",
                imagePath: "assets/not_found.png",
              );
            }

            return MasonryGridView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.searchResults.value.length,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final business = controller.searchResults.value[index];
                return RBusinessContainer(
                  tag: "s${business.name}",
                  business: business,
                  onShowDirectionTap: () async {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
