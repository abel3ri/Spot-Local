import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final PageController pageController = PageController();
  Rx<int> currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentIndex.value = pageController.page!.round();
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
