import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/controllers/location_controller.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:business_dir/app/modules/home/views/widgets/category_item_grid.dart';
import 'package:business_dir/app/modules/home/views/widgets/homepage_search_placeholder.dart';
import 'package:business_dir/app/widgets/r_business_container.dart';
import 'package:business_dir/app/widgets/r_info.dart';
import 'package:business_dir/app/widgets/shimmers/business_shimmer_grid.dart';
import 'package:business_dir/app/widgets/shimmers/category_shimmer_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () async {
                // Scaffold.of(context).openDrawer();
                await Get.find<AuthController>().getUserData();
              },
              icon: const Icon(Icons.sort),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Obx(
            () => controller.isLoading.isTrue
                ? LinearProgressIndicator()
                : SizedBox(),
          ),
        ),
        actions: [
          PopupMenuButton(
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "en_US",
                child: Text("English"),
              ),
              const PopupMenuItem(
                value: "am_ET",
                child: Text("አማርኛ"),
              ),
            ],
            icon: const Icon(Icons.translate_rounded),
            onSelected: (value) {
              List<String> splittedLocale = value.split("_");
              Locale locale = Locale(splittedLocale[0], splittedLocale[1]);
              Get.updateLocale(locale);
            },
          ),
        ],
        title: Text(
          "businessDirectory".tr,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            controller.getAllCategories(),
            controller.getAllBusinesses(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: const Alignment(0, 1.25),
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: "discover".tr,
                            style: Get.textTheme.headlineLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(
                                text: "localBusiness".tr + "!",
                                style: Get.textTheme.headlineLarge!.copyWith(
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
                    return CategoryShimmerGrid();
                  }
                  if (controller.categories.value.isEmpty) {
                    return RInfo(
                      message: "No Category Found!",
                      imagePath: "assets/not_found.png",
                    );
                  }

                  return CategoryItemsGrid();
                }),
                SizedBox(height: Get.height * 0.02),
                const Divider(thickness: .1),
                SizedBox(height: Get.height * 0.02),
                Obx(
                  () {
                    if (controller.isBusinessLoading.isTrue) {
                      return BusinessShimmerGrid();
                    } else if (controller.businesses.value.isEmpty) {
                      return RInfo(
                        message: "No Business Found!",
                        imagePath: "assets/not_found.png",
                      );
                    }
                    return MasonryGridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final business = controller.businesses.value[index];
                        return RBusinessContainer(
                          tag: "h${business.name}",
                          business: business,
                          onShowDirectionTap: () async {
                            controller.isLoading(true);
                            final locationController =
                                Get.find<LocationController>();
                            await locationController.getUserCurrentPosition();
                            controller.isLoading(false);
                            locationController.setBusinessInfo(
                              coords: business.latLng!,
                              name: business.name!,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
