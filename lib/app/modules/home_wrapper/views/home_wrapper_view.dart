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
        () => BottomNavigationBar(
          onTap: controller.onPageChanged,
          currentIndex: controller.index.value,
          backgroundColor: Get.theme.primaryColor,
          selectedItemColor: Get.theme.primaryColor,
          iconSize: 32,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
