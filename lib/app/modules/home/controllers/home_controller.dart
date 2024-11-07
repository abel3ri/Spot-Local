import 'package:business_dir/app/controllers/auth_controller.dart';
import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/providers/category_provider.dart';
import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:business_dir/app/data/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<BusinessModel>> featuredBusinesses = Rx<List<BusinessModel>>([]);
  Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);
  Rx<bool> isBusinessLoading = false.obs;
  Rx<bool> isCategoryLoading = false.obs;
  Rx<bool> isLoading = false.obs;

  Rx<Position?> userPosition = Rx<Position?>(null);
  Rx<BusinessModel?> business = Rx<BusinessModel?>(null);
  final ScrollController scrollController = ScrollController();

  late CategoryProvider categoryProvider;
  late FeaturedProvider featuredProvider;

  void setUserPosition(Position position) {
    userPosition.value = position;
  }

  @override
  void onInit() {
    super.onInit();
    final authController = Get.find<AuthController>();
    authController.getUserData();
    categoryProvider = Get.find<CategoryProvider>();
    featuredProvider = Get.find<FeaturedProvider>();
    getAllCategories();
    getFeaturedBusinesses();
  }

  Future<void> getFeaturedBusinesses() async {
    isBusinessLoading(true);
    final res = await featuredProvider
        .findFeaturedBusinesses(query: {"status": "active"});
    isBusinessLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      featuredBusinesses.value = r;
    });
  }

  Future<void> getUserPosition() async {
    final locationProvider = Get.find<LocationProvider>();
    isBusinessLoading(true);
    final res = await locationProvider.getCurrentPosition();
    isBusinessLoading(false);
    res.fold((l) {
      l.showError();
    }, (Position r) {
      userPosition(r);
    });
  }

  Future<void> getAllCategories() async {
    isCategoryLoading(true);
    final res = await categoryProvider.findAll();
    isCategoryLoading(false);

    res.fold((l) {
      l.showError();
    }, (List<CategoryModel> r) {
      categories(r);
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
