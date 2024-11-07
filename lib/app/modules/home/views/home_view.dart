import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/models/state_model.dart';
import 'package:business_dir/app/modules/home/controllers/filter_controller.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/widgets/category_item_grid.dart';
import 'package:business_dir/app/modules/home/views/widgets/homepage_search_placeholder.dart';
import 'package:business_dir/app/modules/home/views/widgets/r_filter_chip.dart';
import 'package:business_dir/app/modules/home_wrapper/controllers/home_wrapper_controller.dart';
import 'package:business_dir/app/widgets/r_banner.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_button.dart';
import 'package:business_dir/app/widgets/r_header_text.dart';
import 'package:business_dir/app/widgets/r_linear_indicator.dart';
import 'package:business_dir/app/widgets/r_loading.dart';
import 'package:business_dir/app/widgets/r_not_found.dart';
import 'package:business_dir/app/widgets/r_text_icon_button.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_grid.dart';
import 'package:business_dir/app/widgets/shimmers/category_shimmer_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final homeWrapperController = Get.find<HomeWrapperController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                final filterController = Get.put(FilterController());
                showModalBottomSheet(
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  enableDrag: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return Obx(
                      () => SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ).add(const EdgeInsets.only(bottom: 16, left: 16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              children: [
                                RFilterChip(
                                  label: "Unverified",
                                  selected:
                                      filterController.isSelected("Unverified"),
                                  onChanged: (value) {
                                    filterController.toggleFilter("Unverified");
                                  },
                                ),
                                RFilterChip(
                                  label: "Featured",
                                  selected:
                                      filterController.isSelected("Featured"),
                                  onChanged: (value) {
                                    filterController.toggleFilter("Featured");
                                  },
                                ),
                                ...List.generate(
                                    controller.categories.value.length,
                                    (index) {
                                  return RFilterChip(
                                    label:
                                        controller.categories.value[index].name,
                                    selected: filterController.isSelected(
                                        controller
                                            .categories.value[index].name),
                                    onChanged: (value) {
                                      filterController.toggleFilter(controller
                                          .categories.value[index].name);
                                    },
                                  );
                                }),
                              ],
                            ),
                            Obx(() {
                              if (filterController.isStatesLoading.isTrue) {
                                return const SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: RLoading(),
                                );
                              }
                              if (filterController.states.value.isEmpty) {
                                return RTextIconButton.medium(
                                  label: "Fetch states",
                                  onPressed: () async {
                                    await filterController.getAllStates();
                                  },
                                  icon: Icons.refresh,
                                );
                              }

                              return Row(
                                children: [
                                  DropdownButton<StateModel>(
                                    value: filterController.selectedState.value,
                                    hint: const Text("Select state"),
                                    borderRadius: BorderRadius.circular(8),
                                    underline: const SizedBox.shrink(),
                                    alignment: Alignment.centerRight,
                                    items: filterController.states.value
                                        .map((state) {
                                      return DropdownMenuItem(
                                        value: state,
                                        child: Text(state.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      filterController.selectState(value);
                                    },
                                  ),
                                  SizedBox(width: Get.width * 0.04),
                                  DropdownButton<CityModel>(
                                    value: filterController.selectedCity.value,
                                    hint: const Text("Select city"),
                                    borderRadius: BorderRadius.circular(8),
                                    underline: const SizedBox.shrink(),
                                    alignment: Alignment.centerRight,
                                    items: filterController.cities.value
                                        .map((city) {
                                      return DropdownMenuItem(
                                        value: city,
                                        child: Text(city.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      filterController.selectCity(value);
                                    },
                                  ),
                                ],
                              );
                            }),
                            Align(
                              alignment: Alignment.centerRight,
                              child: filterController.isBusinessLoading.isFalse
                                  ? RButton(
                                      child: const Text("Apply"),
                                      onPressed: () async {
                                        filterController.fetchBusinesses();
                                      },
                                    )
                                  : const SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: RLoading(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).then((_) {
                  Get.delete<FilterController>();
                });
              },
              icon: const Icon(Icons.sort),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Obx(
            () => Get.find<LocationController>().isLoading.isTrue
                ? const RLinearIndicator()
                : const SizedBox(),
          ),
        ),
        title: Text(
          "Spot Local - ${"localBusinessFinder".tr}",
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.wait([
          controller.getFeaturedBusinesses(),
          controller.getAllCategories(),
        ]),
        child: ListView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.all(16),
          children: [
            Stack(
              alignment: const Alignment(0, 1.25),
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.38,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: "discover".tr,
                        style: context.textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(
                            text: "${"localBusiness".tr}!",
                            style: context.textTheme.headlineLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  child: HomePageSearchPlaceHolder(),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.06),
            const Divider(thickness: .1),
            SizedBox(height: Get.height * 0.02),
            Obx(() {
              if (controller.isCategoryLoading.isTrue) {
                return const CategoryShimmerGrid();
              } else if (controller.categories.value.isEmpty &&
                  homeWrapperController.index.value == 0) {
                return const RNotFound(label: "No Category Found!");
              } else if (controller.categories.value.isNotEmpty)
                return CategoryItemsGrid();
              return const SizedBox();
            }),
            SizedBox(height: Get.height * 0.02),
            const Divider(thickness: .1),
            SizedBox(height: Get.height * 0.02),
            RHeaderText(headerText: "featuredBusinesses".tr),
            SizedBox(height: Get.height * 0.02),
            Obx(
              () {
                if (controller.isBusinessLoading.isTrue) {
                  return const BusinessShimmerGrid();
                }
                if (controller.featuredBusinesses.value.isEmpty) {
                  return const RBanner();
                }
                return MasonryGridView.builder(
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  itemCount: controller.featuredBusinesses.value.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final business = controller.featuredBusinesses.value[index];
                    return RBusinessContainer(business: business);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
