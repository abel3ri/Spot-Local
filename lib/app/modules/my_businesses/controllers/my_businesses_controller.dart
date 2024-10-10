import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/providers/business_provider.dart';
import 'package:get/get.dart';

class MyBusinessesController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<List<BusinessModel>> businesses = Rx<List<BusinessModel>>([]);
  late BusinessProvider businessProvider;
  @override
  void onInit() {
    super.onInit();
    businessProvider = Get.find<BusinessProvider>();
    getMyBusinesses();
  }

  Future<void> getMyBusinesses() async {
    isLoading(true);
    final res = await businessProvider.getMyBusinesses();
    isLoading(false);
    res.fold((l) {
      l.showError();
    }, (r) {
      businesses.value = r;
      businesses.refresh();
    });
  }
}
