import 'package:business_dir/app/modules/favorite/views/favorite_view.dart';
import 'package:business_dir/app/modules/home/views/home_view.dart';
import 'package:business_dir/app/modules/profile/views/profile_view.dart';
import 'package:business_dir/app/modules/search/views/search_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_wrapper_controller.dart';

class HomeWrapperView extends GetView<HomeWrapperController> {
  final List<Widget> pages = [
    HomeView(),
    SearchView(),
    FavoriteView(),
    ProfileView(),
  ];
  HomeWrapperView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.transparent,
          onDestinationSelected: controller.onPageChanged,
          indicatorColor: Get.theme.primaryColor.withOpacity(.25),
          selectedIndex: controller.index.value,
          elevation: 0,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home, color: Get.theme.primaryColor),
              label: "homeBottom".tr,
              tooltip: "Home",
              selectedIcon: Icon(
                Icons.home_filled,
                color: Get.theme.primaryColor,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.search, color: Get.theme.primaryColor),
              label: "searchBottom".tr,
              tooltip: "Search",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_rounded,
                  color: Get.theme.primaryColor),
              label: "favoritesBottom".tr,
              tooltip: "Favorites",
              selectedIcon: Icon(
                Icons.favorite,
                color: Get.theme.primaryColor,
              ),
            ),
            NavigationDestination(
              icon:
                  Icon(Icons.person_2_outlined, color: Get.theme.primaryColor),
              label: "profileBottom".tr,
              tooltip: "Profile",
              selectedIcon: Icon(
                Icons.person_2_rounded,
                color: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
