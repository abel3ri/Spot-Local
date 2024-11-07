import 'package:business_dir/app/data/models/business_performance_model.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:business_dir/app/data/providers/review_provider.dart';
import 'package:business_dir/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class BusinessDetailsController extends GetxController {
  late ReviewProvider reviewProvider;
  Rx<List<ReviewModel>> reviews = Rx<List<ReviewModel>>([]);
  Rx<ReviewModel?> review = Rx<ReviewModel?>(null);
  Rx<bool> isLoading = false.obs;
  Rx<BusinessPerformanceModel?> businessPerformance =
      Rx<BusinessPerformanceModel?>(null);

  @override
  void onInit() {
    super.onInit();
    reviewProvider = Get.find<ReviewProvider>();
    getAllReviews(businessId: Get.find<HomeController>().business.value!.id!);
    getBusinessPerformance();
  }

  Future<void> getAllReviews({required String businessId}) async {
    isLoading(true);
    final res = await reviewProvider.findAll(businessId: businessId);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      reviews.value = r;
    });
  }

  Future<void> deleteReview({
    required String reviewId,
  }) async {
    isLoading(true);
    final res = await reviewProvider.deleteOne(reviewId: reviewId);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      reviews.value.removeWhere((re) => re.id == reviewId);
      reviews.refresh();
      getBusinessPerformance();
    });
  }

  Future<void> getBusinessPerformance() async {
    isLoading(true);
    final res = await Get.find<BusinessProvider>().getBusinessPerformance(
        businessId: Get.find<HomeController>().business.value!.id!);
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      businessPerformance.value = r;
    });
  }
}
