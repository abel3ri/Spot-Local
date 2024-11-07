import 'package:business_dir/app/data/models/featured_model.dart';
import 'package:business_dir/app/data/providers/featured_provider.dart';
import 'package:get/get.dart';

class FeatureHistoryController extends GetxController {
  Rx<List<FeaturedModel>> featureds = Rx<List<FeaturedModel>>([]);
  Rx<bool> isLoading = false.obs;
  late FeaturedProvider featuredProvider;
  @override
  void onInit() {
    super.onInit();
    featuredProvider = Get.find<FeaturedProvider>();
    fetchMyFeatures();
  }

  Future<void> fetchMyFeatures() async {
    isLoading(true);
    final res = await featuredProvider.myFeatures();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      featureds.value = r;
    });
  }
}
