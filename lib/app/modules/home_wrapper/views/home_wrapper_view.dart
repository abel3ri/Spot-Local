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
          indicatorColor: Get.theme.primaryColor.withOpacity(.4),
          selectedIndex: controller.index.value,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home, color: Get.theme.primaryColor),
              label: "Home",
              tooltip: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.search, color: Get.theme.primaryColor),
              label: "Search",
              tooltip: "Search",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite, color: Get.theme.primaryColor),
              label: "Favorites",
              tooltip: "Favorites",
            ),
            NavigationDestination(
              icon: Icon(Icons.person, color: Get.theme.primaryColor),
              label: "Profile",
              tooltip: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
