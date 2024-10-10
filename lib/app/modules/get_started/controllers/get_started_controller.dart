import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedController extends GetxController {
  Rx<int> currentIndex = Rx<int>(0);
  PageController pageController = PageController(initialPage: 0);
}
