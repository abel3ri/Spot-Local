import 'package:business_dir/app/data/providers/review_provider.dart';
import 'package:business_dir/app/modules/business_details/controllers/business_details_controller.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  Rx<double?> rating = Rx<double?>(null);
  final TextEditingController ratingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ReviewProvider ratingProvider;
  late BusinessDetailsController businessDetailsController;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ratingProvider = Get.find<ReviewProvider>();
    businessDetailsController = Get.find<BusinessDetailsController>();
  }

  void onRatingChanged(double value) {
    rating.value = value;
  }

  Future<void> createRating({required Map<String, dynamic> ratingData}) async {
    isLoading(true);
    final res = await ratingProvider.create(ratingData: ratingData);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      businessDetailsController.reviews.value.insert(0, r);
      businessDetailsController.reviews.refresh();
      businessDetailsController.getBusinessPerformance();
      Get.back();
    });
    ;
  }

  Future<void> updateRating({required Map<String, dynamic> ratingData}) async {
    final businessId = Get.find<HomeController>().business.value!.id;
    isLoading(true);
    final res = await ratingProvider.updateOne(
      ratingData: ratingData,
      reviewId: businessDetailsController.review.value!.id,
    );
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      businessDetailsController.getAllReviews(businessId: businessId!);
      businessDetailsController.getBusinessPerformance();
      Get.back();
    });
    ;
  }

  @override
  void onClose() {
    super.onClose();
    ratingController.dispose();
  }
}
